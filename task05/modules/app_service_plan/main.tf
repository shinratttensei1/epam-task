resource "azurerm_app_service_plan" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    tier     = var.sku_tier
    size     = var.sku_size
    capacity = var.worker_count
  }

  tags = var.tags
}
