resource "azurerm_redis_cache" "redis" {
  name                 = var.redis_name
  location             = var.rg_location
  resource_group_name  = var.rg_name
  sku_name             = "Basic"
  capacity             = 2
  family               = "C"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"

  redis_configuration {
    maxmemory_policy = "allkeys-lru"
  }

  tags = var.tags
}

