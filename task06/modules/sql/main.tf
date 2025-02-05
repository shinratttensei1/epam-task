resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!@#%&*"
}

data "azurerm_key_vault" "existing_kv" {
  name                = var.existingkv_name
  resource_group_name = var.existingkv_rgname
}

resource "azurerm_key_vault_secret" "kv_secret" {
  name         = var.kv_secret_name_for_sql_admin_password
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.existing_kv.id
}

resource "azurerm_key_vault_secret" "kv_secret_username" {
  name         = var.kv_secret_name_for_sql_admin_name
  value        = "sqladmin"
  key_vault_id = data.azurerm_key_vault.existing_kv.id
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = random_password.password.result
  minimum_tls_version          = "1.2"
  tags                         = var.tags

}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "Allow-Azure-Services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "allow_specific_ip" {
  name             = "allow-verification-ip"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

resource "azurerm_mssql_database" "sql_db" {
  name         = var.sql_db_name
  server_id    = azurerm_mssql_server.sql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = var.sql_db_sm
  enclave_type = "VBS"
  tags         = var.tags

}









