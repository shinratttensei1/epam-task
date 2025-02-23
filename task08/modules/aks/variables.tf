variable "aks_name" {
  description = "Azure Kubernetes Service Name"
  type        = string
}

variable "rg_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "rg_location" {
  description = "Azure Resource Group Location"
  type        = string
}

variable "dns_prefix" {
  description = "Azure Kubernetes Service DNS Prefix"
  type        = string
}

variable "node_count" {
  description = "Azure Kubernetes Service Node Count"
  type        = number
}

variable "vm_size" {
  description = "Azure Kubernetes Service VM Size"
  type        = string
}

variable "os_disk_type" {
  description = "Azure Kubernetes Service OS Disk Type"
  type        = string
}
/*
variable "acr_id" {
  description = "Azure Container Registry ID for AKS Image Pull"
  type        = string
}
*/

variable "tags" {
  description = "Azure Kubernetes Service Tags"
  type        = map(any)
}
/*
variable "kv_id" {
  description = "Keyvault ID"
  type        = string
}
*/

variable "tenant_id" {
  description = "Tenant"
  type        = string
}