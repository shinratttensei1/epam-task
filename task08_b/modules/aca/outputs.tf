output "aca_fqdn" {
  description = "Fully Qualified Domain Name of the Azure Container App"
  value       = azurerm_container_app.aca.latest_revision_fqdn
}

output "aca_identity_id" {
  description = "User Assigned Identity ID for ACA"
  value       = azurerm_user_assigned_identity.aca_identity.principal_id
}
