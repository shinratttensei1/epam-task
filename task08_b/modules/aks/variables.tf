variable "aks_name" {
  description = "Azure Kubernetes Service Cluster Name"
  type        = string
}

variable "rg_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "node_pool_name" {
  description = "AKS Default Node Pool Name"
  type        = string
}

variable "node_pool_count" {
  description = "Number of Nodes in AKS"
  type        = number
}

variable "node_pool_vm_size" {
  description = "VM Size for AKS Nodes"
  type        = string
}

variable "node_pool_os_disk_type" {
  description = "OS Disk Type for AKS Nodes"
  type        = string
}

variable "acr_id_scope" {
  description = "Azure Container Registry ID"
  type        = string
}

variable "keyvault_id" {
  description = "Azure Key Vault ID"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}