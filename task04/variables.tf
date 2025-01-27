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
  description = "Admin username for VM"
  type        = string
}

variable "vm_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
}

variable "pip_name" {
  description = "VM Public IP"
  type        = string
}

variable "dns_name" {
  description = "VM DNS Label"
  type        = string
}

variable "nsg_name" {
  description = "Network Security Group Name"
  type        = string
}

variable "nic_name" {
  description = "NIC Name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "nsg_inbound_http" {
  description = "The inbound rule for HTTP"
  type        = string
}

variable "vm_sku" {
  description = "The size of the VM"
  type        = string
}

variable "vm_os_version" {
  description = "Version of the VM"
  type        = string
}

variable "nsg_inbound_ssh" {
  description = "The inbound rule for SSH"
  type        = string
}
