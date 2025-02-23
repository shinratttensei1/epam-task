resource "azurerm_key_vault" "kv" {
  name                = var.kv_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku_name            = var.kv_sku
  tenant_id           = var.tenant_id


  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "user_kv_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions = [
    "Get",
    "List",
    "Create",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge"
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge"
  ]

  depends_on = [azurerm_key_vault.kv]
}

