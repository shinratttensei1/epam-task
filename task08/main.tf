data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = local.rg_location

  tags = var.tags
}

module "acr" {
  source                = "./modules/acr"
  acr_name              = local.acr_name
  rg_name               = azurerm_resource_group.rg.name
  rg_location           = azurerm_resource_group.rg.location
  acr_sku               = var.acr_sku
  git_repository_name   = var.git_repository_name
  git_repository_branch = var.git_repository_branch
  git_repository_owner  = var.git_repository_owner
  git_pat               = var.git_pat
  image_name            = local.image_name
  tags                  = var.tags
}

module "aks" {
  source       = "./modules/aks"
  aks_name     = local.aks_name
  rg_name      = azurerm_resource_group.rg.name
  rg_location  = azurerm_resource_group.rg.location
  dns_prefix   = local.dns_prefix
  node_count   = var.aks_node_count
  vm_size      = var.aks_node_vm_size
  os_disk_type = var.aks_node_os_disk_type
  tenant_id    = data.azurerm_client_config.current.tenant_id
  tags         = var.tags

  depends_on = [module.acr]
}

module "redis" {
  source      = "./modules/redis"
  redis_name  = local.redis_name
  rg_name     = azurerm_resource_group.rg.name
  rg_location = azurerm_resource_group.rg.location
  tags        = var.tags

  depends_on = [module.aks]
}

module "keyvault" {
  source      = "./modules/keyvault"
  kv_name     = local.keyvault_name
  rg_name     = azurerm_resource_group.rg.name
  rg_location = azurerm_resource_group.rg.location
  dns_prefix  = local.dns_prefix
  kv_sku      = var.kv_sku
  tenant_id   = data.azurerm_client_config.current.tenant_id
  object_id   = data.azurerm_client_config.current.object_id
  # redis_hostname = var.redis_hostname
  # redis_primary_key = var.redis_primary_key
  tags       = var.tags
  kv_id      = module.keyvault.kv_id
  depends_on = [module.redis]
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.aks_kubelet_object_id

  depends_on = [module.redis]
}

resource "azurerm_key_vault_access_policy" "aks_kv_policy" {
  key_vault_id = module.keyvault.kv_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.aks.aks_secret_provider_object_id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]

  depends_on = [module.redis]
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname
  value        = module.redis.redis_hostname_value
  key_vault_id = module.keyvault.kv_id

  tags = var.tags

  depends_on = [
    module.keyvault,
    azurerm_key_vault_access_policy.aks_kv_policy
  ]
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_primary_key
  value        = module.redis.redis_primary_key_value
  key_vault_id = module.keyvault.kv_id

  tags = var.tags
  depends_on = [
    module.keyvault,
    azurerm_key_vault_access_policy.aks_kv_policy
  ]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_kv_access_identity_id
    kv_name                    = module.keyvault.kv_name
    redis_url_secret_name      = var.redis_hostname
    redis_password_secret_name = var.redis_primary_key
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })

  depends_on = [azurerm_role_assignment.aks_acr_pull, azurerm_key_vault_access_policy.aks_kv_policy]
}

resource "kubectl_manifest" "app_deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = local.image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  timeouts {
    create = "5m"
  }


  depends_on = [module.aks, kubectl_manifest.secret_provider, azurerm_key_vault_secret.redis_hostname, azurerm_key_vault_secret.redis_primary_key]
}

module "aci" {
  source                      = "./modules/aci"
  aci_name                    = local.aci_name
  rg_name                     = azurerm_resource_group.rg.name
  rg_location                 = azurerm_resource_group.rg.location
  aci_sku                     = var.aci_sku
  tags                        = var.tags
  dns_name_label              = local.dns_prefix
  image_name                  = local.image_name
  cpu_cores                   = local.cpu_cores
  memory_in_gb                = local.memory_in_gb
  port                        = local.port
  redis_hostname              = azurerm_key_vault_secret.redis_hostname.value
  redis_primary_key           = azurerm_key_vault_secret.redis_primary_key.value
  container_registry_username = module.acr.acr_admin_username
  container_registry_server   = module.acr.acr_login_server
  container_registry_pass     = module.acr.acr_admin_password

  depends_on = [

  ]

}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.rg_name
  depends_on          = [module.aks]
}

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  token                  = data.azurerm_kubernetes_cluster.aks.kube_config.0.password
  load_config_file       = false
  apply_retry_count      = 30
}


resource "kubectl_manifest" "app_service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

data "kubernetes_service" "app_service" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [module.aci]
}
