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

variable "tags" {
  description = "Azure Redis Cache Tags"
  type        = map(any)
}
