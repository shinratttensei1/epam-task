output "redis_hostname_value" {
  value = azurerm_redis_cache.redis.hostname
}

output "redis_primary_key_value" {
  value     = azurerm_redis_cache.redis.primary_access_key
  sensitive = true
}
