data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = local.rg_location
}

module "redis" {
  source            = "./modules/redis"
  redis_name        = local.redis_name
  rg_name           = azurerm_resource_group.rg.name
  rg_location       = azurerm_resource_group.rg.location
  kv_id             = module.keyvault.kv_id
  redis_hostname    = local.redis_hostname
  redis_primary_key = local.redis_primary_key
  tags              = local.tags
}

module "aci" {
  source            = "./modules/aci"
  aci_name          = local.aci_name
  rg_name           = azurerm_resource_group.rg.name
  rg_location       = azurerm_resource_group.rg.location
  aci_sku           = local.aci_sku
  tags              = local.tags
  dns_name_label    = local.dns_prefix
  image_name        = local.image_name
  cpu_cores         = local.cpu_cores
  memory_in_gb      = local.memory_in_gb
  port              = local.port
  redis_hostname    = module.redis.redis_hostname
  redis_primary_key = module.redis.redis_primary_key
}

module "acr" {
  source                = "./modules/acr"
  acr_name              = local.acr_name
  rg_name               = azurerm_resource_group.rg.name
  rg_location           = azurerm_resource_group.rg.location
  acr_sku               = local.acr_sku
  git_repository_url    = local.git_repository_url
  git_repository_branch = local.git_repository_branch
  git_pat               = local.git_pat
  image_name            = local.image_name

  tags = local.tags
}

module "aks" {
  source       = "./modules/aks"
  aks_name     = local.aks_name
  rg_name      = azurerm_resource_group.rg.name
  rg_location  = azurerm_resource_group.rg.location
  dns_prefix   = local.dns_prefix
  node_count   = local.aks_node_count
  vm_size      = local.aks_node_vm_size
  os_disk_type = local.aks_node_os_disk_type
  acr_id       = module.acr.acr_id
  tags         = local.tags
}

module "keyvault" {
  source      = "./modules/keyvault"
  kv_name     = local.kv_name
  rg_name     = azurerm_resource_group.rg.name
  rg_location = azurerm_resource_group.rg.location
  dns_prefix  = local.dns_prefix
  kv_sku      = local.kv_sku
  tenant_id   = data.azurerm_client_config.current.tenant_id
  object_id   = data.azurerm_client_config.current.object_id

  tags = local.tags
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_identity_id
    kv_name                    = module.keyvault.kv_name
    redis_url_secret_name      = module.redis.redis_hostname
    redis_password_secret_name = module.redis.redis_primary_key
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })

  depends_on = [module.aks, module.keyvault]
}


resource "kubectl_manifest" "app_deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = local.image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.phase"
      value = "Running"
    }

    condition {
      type   = "ContainersReady"
      status = "True"
    }

    condition {
      type   = "Ready"
      status = "True"
    }
  }
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

data "kubernetes_service" "app_service" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [module.aks]
}