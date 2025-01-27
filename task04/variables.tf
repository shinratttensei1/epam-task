variable "rg_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "vm_username" {
  description = "Username for the Virtual Machine"
  type        = string
}

variable "vm_password" {
  description = "VM Password"
  type        = string
  sensitive   = true
}

variable "nic_name" {
  description = "Name of the Network Interface Card"
  type        = string
}

variable "location" {
  description = "Azure Region for resources"
  type        = string
}

variable "pip_name" {
  description = "Name of the Public IP"
  type        = string
}

variable "dns_name" {
  description = "DNS name for the Public IP"
  type        = string
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "nsg_inbound_http" {
  description = "Name of the NSG Rule for HTTP"
  type        = string
}

variable "nsg_inbound_ssh" {
  description = "Name of the NSG Rule for SSH"
  type        = string
}

variable "vm_os_version" {
  description = "OS version of the VM"
  type        = string
}

variable "vm_sku" {
  description = "SKU for the VM"
  type        = string
}

variable "tags" {
  description = "Tags to associate with resources"
  type        = map(string)
}
