variable "name" {
  type        = string
  description = "The name of the App Service."
}

variable "location" {
  type        = string
  description = "The location of the App Service."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "app_service_plan_id" {
  type        = string
  description = "The ID of the App Service Plan."
}

variable "ip_restrictions" {
  type = list(object({
    name        = string
    ip_address  = optional(string)
    service_tag = optional(string)
    action      = string
    priority    = number
  }))
  description = "List of IP restrictions."
}

variable "tags" {
  type        = map(string)
  description = "Tags for the App Service."
}
