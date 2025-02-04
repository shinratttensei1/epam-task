resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

data "azurerm_client_config" "current" {}


module "sql" {
  source                 = "./modules/sql"
  location               = var.location
  rg_name                = azurerm_resource_group.rg.name
  sql_server_name        = local.sql_server_name
  sql_db_name            = local.sql_db_name
  sql_db_sm              = var.sql_db_sm
  sql_server_fw_rulename = var.sql_server_fw_rulename

  existingkv_rgname = var.existingkv_rgname
  existingkv_name   = var.existingkv_name

  kv_secret_name_for_sql_admin_name     = var.kv_secret_name_for_sql_admin_name
  kv_secret_name_for_sql_admin_password = var.kv_secret_name_for_sql_admin_password
  verification_agent_ip                 = var.verification_agent_ip

  allowed_ip_address = var.allowed_ip_address
  tenant_id          = data.azurerm_client_config.current.tenant_id
  tags               = var.tags
}

module "webapp" {
  source                = "./modules/webapp"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  sku_name              = var.asp_sku
  app_service_plan_name = local.asp_name
  app_service_plan_sku  = var.asp_sku
  app_service_name      = local.app_name
  app_dotnet_version    = var.app_dotnet_version
  sql_connection_string = module.sql.sql_connection_string
  tags                  = var.tags
}


