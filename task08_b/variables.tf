variable "namespace_prefix" {
  description = "Namespace For Resource Namings"
  type        = string
}

variable "redis_aci_dns_name" {
  description = "Redis ACI DNS Name"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}

variable "docker_image_name" {
  description = "Docker Image Name"
  type        = string
}

variable "node_pool_name" {
  description = "AKS Default Node Pool Name"
  type        = string
}

variable "node_pool_count" {
  description = "Number of Nodes in AKS"
  type        = number
}

variable "node_pool_vm_size" {
  description = "VM Size for AKS Nodes"
  type        = string
}

variable "node_pool_os_disk_type" {
  description = "OS Disk Type for AKS Nodes"
  type        = string
}
