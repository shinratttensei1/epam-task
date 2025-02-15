variable "rg_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "rg_location" {
  description = "Azure Resource Group Location"
  type        = string
}

variable "redis_name" {
  description = "Azure Redis Cache Name"
  type        = string
}

variable "kv_id" {
  description = "Azure Key Vault ID"
  type        = string
}

variable "redis_hostname" {
    description = "Redis Hostname"
    type = string
}

variable "redis_primary_key" {
    description = "Redis Primary Key"
    type = string
}

variable "tags" {
  description = "Azure Redis Cache Tags"
  type        = map(any)
}
