variable "rg_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "RG Location"
  type        = string
}

variable "redis_aci_name" {
  description = "Azure Container Instance Redis Name"
  type        = string
}


variable "redis_aci_dns_name" {
  description = "Redis ACI DNS Name"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}