module "resource_groups" {
  source = "./modules/resource_group"

  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = each.value.tags
}

module "app_service_plans" {
  source = "./modules/app_service_plan"

  for_each = var.app_service_plans

  name                = each.value.name
  location            = module.resource_groups[each.value.resource_group_key].location
  resource_group_name = module.resource_groups[each.value.resource_group_key].name

  sku_tier     = each.value.sku_tier
  sku_size     = each.value.sku_size
  worker_count = each.value.worker_count
  tags         = each.value.tags
}

locals {
  ip_restrictions = [
    {
      name       = "allow-ip"
      ip_address = "18.153.146.156/32"
      action     = "Allow"
      priority   = 100
    },
    {
      name        = "allow-tm"
      service_tag = "AzureTrafficManager"
      action      = "Allow"
      priority    = 200
    }
  ]
}

module "app_services" {
  source = "./modules/app_service"

  for_each = var.app_services

  name                = each.value.name
  location            = module.resource_groups[each.value.resource_group_key].location
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  app_service_plan_id = module.app_service_plans[each.value.app_service_plan_key].id

  ip_restrictions = local.ip_restrictions

  tags = each.value.tags
}

module "traffic_manager" {
  source = "./modules/traffic_manager"

  name                   = var.traffic_manager.name
  resource_group_name    = module.resource_groups[var.traffic_manager.resource_group_key].name
  traffic_routing_method = var.traffic_manager.routing_method

  tags = var.traffic_manager.tags

  endpoints = [
    {
      name               = "endpoint-app1"
      target_resource_id = module.app_services["app1"].id
    },
    {
      name               = "endpoint-app2"
      target_resource_id = module.app_services["app2"].id
    }
  ]
}