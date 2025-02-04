variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group in which all resources will be created."
  type        = string
}

variable "asp_name" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which all resources will be created."
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "app_service_plan_sku" {
  description = "The SKU of the App Service Plan."
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service."
  type        = string
}

variable "app_dotnet_version" {
  description = "The .NET version for the App Service."
  type        = string
}

variable "sql_connection_string" {
  description = "The connection string for the SQL Database."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU of the App Service Plan."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
}

