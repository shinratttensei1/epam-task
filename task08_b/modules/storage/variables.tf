variable "storage_account_name" {
  description = "Azure Storage Account Name"
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

variable "container_name" {
  description = "Storage Container Name"
  type        = string
}

variable "archive_blob_name" {
  description = "Name of the archive file in Azure Storage"
  type        = string
}
