
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                      = var.kv_name
  location                  = var.location
  resource_group_name       = var.rg_name
  sku_name                  = "standard"
  enable_rbac_authorization = false
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  tags                      = var.tags
}

resource "azurerm_key_vault_access_policy" "user_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Restore",
    "Purge"
  ]
}


resource "azurerm_key_vault_secret" "redis_password" {
  name         = "redis-password"
  value        = var.random_redis_password
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.user_policy]
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = var.redis_hostname
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.user_policy]
}
