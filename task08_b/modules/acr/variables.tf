variable "acr_name" {
  description = "Azure Container Registry Name"
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

variable "storage_account_name" {
  description = "Azure Storage Account Name"
  type        = string
}

variable "storage_container_name" {
  description = "Storage Container Name"
  type        = string
}

variable "storage_blob_name" {
  description = "Blob Name (tar.gz file)"
  type        = string
}

variable "sas_token" {
  description = "Storage Account SAS Token"
  type        = string
}

variable "docker_image_name" {
  description = "Docker Image Name"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}