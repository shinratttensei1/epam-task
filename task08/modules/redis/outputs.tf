output "redis_hostname" {
  value = azurerm_key_vault_secret.redis_hostname.value
}

output "redis_primary_key" {
  value     = azurerm_key_vault_secret.redis_primary_key.value
  sensitive = true
}
