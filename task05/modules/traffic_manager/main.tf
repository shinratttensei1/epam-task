resource "azurerm_traffic_manager_profile" "this" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.traffic_routing_method

  dns_config {
    relative_name = var.name
    ttl           = var.ttl
  }

  monitor_config {
    protocol                     = var.monitor_protocol
    port                         = var.monitor_port
    path                         = var.monitor_path
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = var.tags
}

resource "azurerm_traffic_manager_azure_endpoint" "this" {
  count = length(var.endpoints)  # Single resource, multiple endpoints

  name                 = var.endpoints[count.index].name
  profile_id           = azurerm_traffic_manager_profile.this.id
  target_resource_id   = var.endpoints[count.index].target_resource_id
  always_serve_enabled = true
}
