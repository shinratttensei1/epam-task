output "storage_account_name" {
  description = "Storage Account Name"
  value       = azurerm_storage_account.storage.name
}

output "container_name" {
  description = "Storage Container Name"
  value       = azurerm_storage_container.container.name
}

output "archive_blob_name" {
  description = "Application Archive Blob Name"
  value       = azurerm_storage_blob.app_blob.name
}

output "sas_token" {
  description = "Shared Access Signature (SAS) Token for accessing Storage"
  value       = data.azurerm_storage_account_sas.sas.sas
  sensitive   = true
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}