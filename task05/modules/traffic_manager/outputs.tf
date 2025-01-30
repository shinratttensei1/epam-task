output "traffic_manager_fqdn" {
  description = "The FQDN of the Traffic Manager Profile."
  value       = azurerm_traffic_manager_profile.this.fqdn
}
