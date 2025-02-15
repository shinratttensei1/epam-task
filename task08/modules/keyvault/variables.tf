variable "rg_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "rg_location" {
  description = "Azure Resource Group Location"
  type        = string
}

variable "kv_name" {
  description = "Azure Key Vault Name"
  type        = string
}

variable "kv_sku" {
  description = "Azure Key Vault SKU"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "object_id" {
  description = "Azure Object ID"
  type        = string
}

variable "dns_prefix" {
  description = "Azure Kubernetes Service DNS Prefix"
  type        = string
}

variable "tags" {
  description = "Azure Kubernetes Service Tags"
  type        = map(any)
}