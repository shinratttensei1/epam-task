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

data "azurerm_redis_cache" "redis_info" {
  name                = azurerm_redis_cache.redis.name
  resource_group_name = azurerm_redis_cache.redis.resource_group_name
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname
  value        = data.azurerm_redis_cache.redis_info.hostname
  key_vault_id = var.kv_id

  tags = var.tags
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_primary_key
  value        = data.azurerm_redis_cache.redis_info.primary_access_key
  key_vault_id = var.kv_id

  tags = var.tags
}