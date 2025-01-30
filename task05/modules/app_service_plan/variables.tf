variable "name" {
  type        = string
  description = "The name of the App Service Plan."
}

variable "location" {
  type        = string
  description = "The Azure region where the App Service Plan will be deployed."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for this App Service Plan."
}

variable "os_type" {
  type        = string
  description = "The operating system type. Possible values: Windows, Linux."
  default     = "Windows"
}

variable "sku_name" {
  type        = string
  description = "The SKU for the App Service Plan."
}

variable "worker_count" {
  type        = number
  description = "The number of workers allocated."
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the App Service Plan."
}
