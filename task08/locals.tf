locals {
  prefix = "cmtr-cc456562-mod8"

  # Resource Group
  rg_name     = join("-", [local.prefix, "rg"])
  rg_location = "eastus2"

  # ARCS
  arcs_name     = join("-", [local.prefix, "redis"])
  arcs_capacity = 2
  arcs_family   = "C"

  # Azure Key Vault  
  kv_name           = join("-", [local.prefix, "kv"])
  kv_sku            = "standard"
  redis_primary_key = "redis-primary-key"
  redis_hostname    = "redis-hostname"

  # Azure Container Registry
  acr_name   = "cmtrcc456562mod8cr"
  acr_sku    = "Basic"
  image_name = join("-", [local.prefix, "app"])

  # Azure Container Instance
  aci_name = join("-", [local.prefix, "aci"])
  aci_sku  = "Standard"

  # Azure Kubernetes Service
  aks_name                   = join("-", [local.prefix, "aks"])
  aks_default_node_pool_name = "system"
  aks_node_count             = 1
  aks_node_vm_size           = "Standard_D2ads_v5"
  aks_node_os_disk_type      = "Ephemeral"

  # Common tags
  tags = {
    Creator = "bibarys_mukhambetiyar@epam.com"
  }


  # Additional variables
  port         = 80
  cpu_cores    = 2
  memory_in_gb = 4
  dns_prefix   = "cmtrcc456562mod8"

  git_repository_url    = "https://github.com/shinratttensei1/epam-task.git"
  git_repository_branch = "main"

  redis_name = join("-", [local.prefix, "redis"])
}