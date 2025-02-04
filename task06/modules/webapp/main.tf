locals {
  prefix   = "cmaz-cc456562-mod6"
  asp_name = format("%s-asp", local.prefix)
  app_name = format("%s-app", local.prefix)
  rg_name  = format("%s-rg", local.prefix)
}

resource "azurerm_service_plan" "asp" {
  name                = local.asp_name
  location            = var.location
  resource_group_name = local.rg_name
  os_type             = "Linux"
  sku_name            = var.sku_name

  tags = var.tags
}

resource "azurerm_linux_web_app" "webapp" {
  name                = local.app_name
  resource_group_name = local.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      dotnet_version = var.app_dotnet_version
    }
  }



  app_settings = {
    SQLAZURECONNSTR = var.sql_connection_string
  }

  tags = var.tags
}
