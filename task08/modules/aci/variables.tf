variable "aci_name" {
  description = "Azure Container Instance Name"
  type        = string
}

variable "rg_location" {
  description = "Azure Resource Group Location"
  type        = string
}

variable "rg_name" {
  description = "Azure Resource Group Resource Group Name"
  type        = string
}

variable "aci_sku" {
  description = "Azure Container Instance SKU"
  type        = string
}

variable "dns_name_label" {
  description = "Azure Container Group DNS Name Label"
  type        = string
}

variable "tags" {
  description = "Azure Container Group Tags"
  type        = map(any)
}

variable "image_name" {
  description = "Azure Container Group Image"
  type        = string
}

variable "cpu_cores" {
  description = "Azure Container Group CPU"
  type        = number
}

variable "memory_in_gb" {
  description = "Azure Container Group Memory"
  type        = number
}

variable "port" {
  description = "Azure Container Group Port"
  type        = number
}

variable "redis_hostname" {
  description = "Azure Key Vault Redis Hostname"
  type        = string
}

variable "redis_primary_key" {
  description = "Azure Key Vault Redis Primary Key"
  type        = string
}
