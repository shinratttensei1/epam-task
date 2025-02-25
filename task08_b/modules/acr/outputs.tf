output "acr_id" {
  description = "Azure Container Registry ID"
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "Azure Container Registry Login Server"
  value       = azurerm_container_registry.acr.login_server
}

