variable "name" {
  type        = string
  description = "The name of the Traffic Manager profile."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "traffic_routing_method" {
  type        = string
  description = "The traffic routing method (Performance, Weighted, Priority, etc.)."
}

variable "ttl" {
  type        = number
  default     = 100
  description = "DNS TTL in seconds."
}

variable "monitor_protocol" {
  type        = string
  default     = "HTTP"
  description = "Protocol for the health probe."
}

variable "monitor_port" {
  type        = number
  default     = 80
  description = "Port for the health probe."
}

variable "monitor_path" {
  type        = string
  default     = "/"
  description = "Path for the health probe."
}

variable "endpoints" {
  type = list(object({
    name               = string
    target_resource_id = string
  }))
  description = "List of Traffic Manager endpoints."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the Traffic Manager resource."
}
