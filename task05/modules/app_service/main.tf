resource "azurerm_windows_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id

  site_config {

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        name        = ip_restriction.value.name
        ip_address  = ip_restriction.value.ip_address
        service_tag = ip_restriction.value.service_tag
        action      = ip_restriction.value.action
        priority    = ip_restriction.value.priority
      }
    }
  }

  tags = var.tags
}
