variable "rg_name" {
  description = "Resource Group Name"
  type        = string
}

variable "kv_name" {
  description = "Azure Key Vault Name"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}

variable "aks_identity_id" {
  description = "AKS Identity ID"
  type        = string
}

variable "acr_login_server" {
  description = "ACR Login Server"
  type        = string
}

variable "docker_image_name" {
  description = "Docker Image Name"
  type        = string
}