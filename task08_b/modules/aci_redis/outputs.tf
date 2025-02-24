output "redis_fqdn" {
  value = "${azurerm_container_group.redis.dns_name_label}.eastus.azurecontainer.io"
}

output "redis_password" {
  value = random_password.redis_password.result
}