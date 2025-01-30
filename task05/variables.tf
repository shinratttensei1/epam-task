variable "resource_groups" {
  description = "Resource Groups to create"
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}

variable "app_service_plans" {
  description = "App Service Plans to create"
  type = map(object({
    name               = string
    sku_tier           = string
    sku_size           = string
    worker_count       = number
    resource_group_key = string
    tags               = map(string)
  }))
}

variable "app_services" {
  description = "Web Apps to create"
  type = map(object({
    name                 = string
    resource_group_key   = string
    app_service_plan_key = string
    tags                 = map(string)
  }))
}

variable "traffic_manager" {
  description = "Traffic Manager profile to create"
  type = object({
    name               = string
    resource_group_key = string
    routing_method     = string
    tags               = map(string)
  })
}

variable "verification_agent_ip_address" {
  type        = string
  description = "Verification agent IP address allowed in Web App access restrictions"
  default     = "18.153.146.156/32"
}

variable "access_restriction_allow_ip_rule_name" {
  type        = string
  description = "Rule name for allowing verification agent IP"
  default     = "allow-ip"
}

variable "access_restriction_allow_tm_service_tag_rule_name" {
  type        = string
  description = "Rule name for allowing Azure Traffic Manager service tag"
  default     = "allow-tm"
}
