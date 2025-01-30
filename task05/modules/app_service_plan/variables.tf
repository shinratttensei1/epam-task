variable "name" {
  type        = string
  description = "The name of the App Service Plan"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the App Service Plan"
}

variable "sku_tier" {
  type        = string
  description = "The pricing tier of the App Service Plan (e.g. PremiumV3)"
}

variable "sku_size" {
  type        = string
  description = "The instance size of the App Service Plan (e.g. P1v3)"
}

variable "worker_count" {
  type        = number
  description = "Number of workers (capacity)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the App Service Plan"
}
