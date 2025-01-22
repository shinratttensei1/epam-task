variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "storageaccount_name" {
  description = "The name of the Storage Account"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "subnet1_name" {
  description = "The name of the first Subnet"
  type        = string
}

variable "subnet2_name" {
  description = "The name of the second Subnet"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}
