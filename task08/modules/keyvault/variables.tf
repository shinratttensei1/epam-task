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

variable "dns_prefix" {
  description = "Azure Kubernetes Service DNS Prefix"
  type        = string
}

variable "tags" {
  description = "Azure Kubernetes Service Tags"
  type        = map(any)
}

variable "object_id" {
  description = "The object ID of the AKS Key Vault Secrets Provider identity"
  type        = string
}

/*
variable "redis_hostname_value" {
  description = "Redis hostname value"
  type = string
}

variable "redis_primary_key_value" {
  description = "Redis primary key value"
  type = string
}

variable "redis_hostname" {
  description = "redis hostname"
  type = string
}

variable "redis_primary_key" {
  description = "Redis primary key"
  type = string
}
*/
variable "kv_id" {
  description = "KV ID"
  type        = string
}