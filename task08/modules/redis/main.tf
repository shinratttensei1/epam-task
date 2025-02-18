resource "azurerm_redis_cache" "redis" {
  name                 = var.redis_name
  location             = var.rg_location
  resource_group_name  = var.rg_name
  sku_name             = "Standard"
  capacity             = 2
  family               = "C"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"

  redis_configuration {
    maxmemory_policy = "allkeys-lru"
  }

  tags = var.tags
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.kv_id

  tags = var.tags

  depends_on = [
    azurerm_redis_cache.redis
  ]
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_primary_key
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.kv_id

  tags = var.tags

  depends_on = [
    azurerm_redis_cache.redis
  ]
}