variable "kv_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group where Key Vault will be deployed"
  type        = string
}

variable "location" {
  description = "Azure Region for Key Vault deployment"
  type        = string
}


variable "random_redis_password" {
  description = "Key Vault secret name for Redis password"
  type        = string
}

variable "redis_hostname" {
  description = "The dynamically generated Redis hostname from Azure Container Instance (ACI)"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}
