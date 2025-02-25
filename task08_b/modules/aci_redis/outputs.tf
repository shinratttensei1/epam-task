output "redis_password" {
  value = random_password.redis_password.result
}

output "redis_fqdn" {
  value       = azurerm_container_group.redis.fqdn
  description = "Redis Hostname"
}

output "redis_dns_name" {
  value = azurerm_container_group.redis.fqdn
}


