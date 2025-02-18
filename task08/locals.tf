locals {
  # Prefix for resource names
  prefix = var.prefix

  # Resource Group Name
  rg_name     = join("-", [local.prefix, "rg"])
  rg_location = var.location

  # Azure Redis Cache
  redis_name = join("-", [local.prefix, "redis"])

  # Azure Key Vault  
  keyvault_name = join("-", [local.prefix, "kv"])

  # Azure Container Registry
  acr_name   = join("", [replace(local.prefix, "-", ""), "cr"])
  image_name = join("-", [local.prefix, "app"])

  # Azure Container Instance
  aci_name = join("-", [local.prefix, "ci"])

  # Azure Kubernetes Service
  aks_name = join("-", [local.prefix, "aks"])

  # DNS Prefix
  dns_prefix = join("-", [local.prefix, "dns"])

  # Additional variables
  port         = var.port
  cpu_cores    = var.cpu_cores
  memory_in_gb = var.memory_in_gb

  # Common Tags
  tags = var.tags
}
