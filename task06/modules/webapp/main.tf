resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = var.sku_name

  tags = var.tags

}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.app_service_name
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      dotnet_version = var.app_dotnet_version
    }
  }


  connection_string {
    name  = "SQLAZURECONNSTR"
    type  = "SQLAzure"
    value = var.sql_connection_string
  }

  tags = var.tags
}
