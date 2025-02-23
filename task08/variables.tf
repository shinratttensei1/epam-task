variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "location" {
  description = "Azure Resource Group Location"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}


# Azure Redis Cache
variable "redis_capacity" {
  description = "Azure Redis Cache capacity"
  type        = number
}

variable "redis_family" {
  description = "Azure Redis SKU Family"
  type        = string
}

# Azure Key Vault
variable "kv_sku" {
  description = "Azure Key Vault SKU"
  type        = string
}

variable "redis_primary_key" {
  description = "Redis primary key secret name in Key Vault"
  type        = string
}

variable "redis_hostname" {
  description = "Redis hostname secret name in Key Vault"
  type        = string
}

# Azure Container Registry
variable "acr_sku" {
  description = "Azure Container Registry SKU"
  type        = string
}

# Azure Container Instance
variable "aci_sku" {
  description = "Azure Container Instance SKU"
  type        = string
}

# Azure Kubernetes Service
variable "aks_node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
}

variable "aks_node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
}

variable "aks_node_os_disk_type" {
  description = "OS Disk type for AKS nodes"
  type        = string
}

# Additional Variables
variable "port" {
  description = "Application port"
  type        = number
}

variable "cpu_cores" {
  description = "Number of CPU cores for container instance"
  type        = number
}

variable "memory_in_gb" {
  description = "Memory allocated for container instance"
  type        = number
}

# Git Variables
variable "git_repository_name" {
  description = "GitHub Repository Name"
  type        = string
}

variable "git_repository_branch" {
  description = "GitHub Repository Branch"
  type        = string
}

variable "git_repository_owner" {
  description = "Git Repo Owner Name"
  type        = string
}


variable "git_pat" {
  description = "git PAT"
  type        = string
  sensitive   = true
}