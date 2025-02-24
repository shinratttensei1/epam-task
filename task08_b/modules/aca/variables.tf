variable "aca_name" {
  description = "Azure Container App Name"
  type        = string
}

variable "aca_env_name" {
  description = "Azure Container App Environment Name"
  type        = string
}

variable "resource_group" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
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

variable "keyvault_id" {
  description = "Azure Key Vault ID"
  type        = string
}

variable "redis_url_secret_id" {
  description = "Key Vault Secret ID for Redis URL"
  type        = string
}

variable "redis_password_secret_id" {
  description = "Key Vault Secret ID for Redis Password"
  type        = string
}

variable "acr_id_scope" {
  description = "ACR ID"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}