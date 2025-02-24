output "keyvault_id" {
  description = "Azure Key Vault ID"
  value       = azurerm_key_vault.kv.id
}

output "redis_password" {
  description = "Redis Password Secret Name"
  value       = azurerm_key_vault_secret.redis_password.value
}

output "redis_hostname" {
  description = "Redis Hostname Secret Name"
  value       = azurerm_key_vault_secret.redis_hostname.value
}

output "redis_url_secret_id" {
  description = "Azure Key Vault Secret ID for Redis URL"
  value       = azurerm_key_vault_secret.redis_hostname.id
}

output "redis_password_secret_id" {
  description = "Azure Key Vault Secret ID for Redis Password"
  value       = azurerm_key_vault_secret.redis_password.id
}
