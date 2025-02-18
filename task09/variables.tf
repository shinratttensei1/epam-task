variable "unique_id" {
    description = "Resources naming convention"
    type = string
}

variable "vnet_space" {
    description = "Existing Virtual Network Address Space"
    type = string
}

variable "subnet_name" {
    description = "Existing Subnet name (AKS Cluster subnet)"
    type = string
}

variable "subnet_space" {
    description = "Existing Subnet Address Space (AKS Cluster subnet)"
    type = string
}

variable "LB_IP_ADDRESS" {
    description = "AKS load-balancer public IP"
    type = string
}

variable "tags" {
    description = "Tags"
    type = map(string)
}