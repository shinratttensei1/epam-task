variable "name" {
  type        = string
  description = "The name of the Windows Web App"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group in which to create the Web App"
}

variable "location" {
  type        = string
  description = "Azure location for the Web App"
}

variable "app_service_plan_id" {
  type        = string
  description = "ID of the App Service Plan to host this Web App"
}

variable "ip_restrictions" {
  type = list(
    object({
      name        = string
      ip_address  = optional(string)
      service_tag = optional(string)
      action      = string
      priority    = optional(number)
    })
  )
  default = []
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the Web App"
}
