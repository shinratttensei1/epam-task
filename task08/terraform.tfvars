# Prefix for resource naming
prefix = "cmtr-cc456562-mod8"

# Azure Location
location = "West Europe"

# Azure Resource Group Tags
tags = {
  Creator = "bibarys_mukhambetiyar@epam.com"
}

# Azure Redis Cache
redis_capacity = 2
redis_family   = "C"

# Azure Key Vault
kv_sku            = "standard"
redis_primary_key = "redis-primary-key"
redis_hostname    = "redis-hostname"

# Azure Container Registry
acr_sku = "Basic"

# Azure Container Instance
aci_sku = "Standard"

# Azure Kubernetes Service
aks_node_count        = 1
aks_node_vm_size      = "Standard_D2ads_v5"
aks_node_os_disk_type = "Ephemeral"

# Additional Variables
port         = 8080
cpu_cores    = 2
memory_in_gb = 4

# Git Variables
git_repository_name   = "epam-task"
git_repository_owner  = "shinratttensei1"
git_repository_branch = "main"
