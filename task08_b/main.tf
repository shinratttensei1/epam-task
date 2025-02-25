resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = local.location

  tags = var.tags
}

module "aci_redis" {
  source             = "./modules/aci_redis"
  rg_name            = azurerm_resource_group.rg.name
  location           = azurerm_resource_group.rg.location
  redis_aci_name     = local.redis_aci_name
  redis_aci_dns_name = var.redis_aci_dns_name

  tags = var.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}


module "keyvault" {
  source                = "./modules/keyvault"
  kv_name               = local.keyvault_name
  location              = azurerm_resource_group.rg.location
  rg_name               = azurerm_resource_group.rg.name
  redis_hostname        = module.aci_redis.redis_fqdn
  random_redis_password = module.aci_redis.redis_password

  tags = var.tags

  depends_on = [
    module.aci_redis
  ]
}

module "storage" {
  source               = "./modules/storage"
  storage_account_name = local.sa_name
  resource_group       = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  container_name       = "app-content"
  archive_blob_name    = "app.tar.gz"

  tags = var.tags
}

module "acr" {
  source                 = "./modules/acr"
  acr_name               = local.acr_name
  resource_group         = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  storage_account_name   = module.storage.storage_account_name
  storage_container_name = module.storage.container_name
  storage_blob_name      = module.storage.archive_blob_name
  sas_token              = module.storage.sas_token
  docker_image_name      = var.docker_image_name

  tags = var.tags
}


module "aks" {
  source                 = "./modules/aks"
  aks_name               = local.aks_name
  rg_name                = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  node_pool_name         = var.node_pool_name
  node_pool_count        = var.node_pool_count
  node_pool_vm_size      = var.node_pool_vm_size
  node_pool_os_disk_type = var.node_pool_os_disk_type
  acr_id_scope           = module.acr.acr_id
  keyvault_id            = module.keyvault.keyvault_id

  tags = var.tags

  depends_on = [module.acr, module.keyvault]
}

module "aca" {
  source                   = "./modules/aca"
  aca_name                 = local.aca_name
  aca_env_name             = local.aca_env_name
  resource_group           = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  acr_login_server         = module.acr.acr_login_server
  docker_image_name        = var.docker_image_name
  keyvault_id              = module.keyvault.keyvault_id
  redis_url_secret_id      = module.keyvault.redis_url_secret_id
  redis_password_secret_id = module.keyvault.redis_password_secret_id
  redis_url                = module.keyvault.redis_hostname
  redis_password           = module.keyvault.redis_password
  acr_id_scope             = module.acr.acr_id

  tags = var.tags

  depends_on = [module.acr, module.keyvault]
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.rg_name
  depends_on          = [module.aks]
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  token                  = data.azurerm_kubernetes_cluster.aks.kube_config.0.password
  load_config_file       = false
}

module "k8s" {
  source            = "./modules/k8s"
  aks_identity_id   = module.aks.aks_kv_access_identity_id
  kv_name           = local.keyvault_name
  acr_login_server  = module.acr.acr_login_server
  docker_image_name = var.docker_image_name

  rg_name = azurerm_resource_group.rg.name

  tags = var.tags

  providers = {
    kubectl    = kubectl
    kubernetes = kubernetes
    azurerm    = azurerm
  }

  depends_on = [
    module.aks,
    module.acr,
    module.keyvault,
    module.aci_redis
  ]
} 