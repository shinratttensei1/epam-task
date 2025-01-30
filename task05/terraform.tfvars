resource_groups = {
  rg1 = {
    name     = "cmaz-cc456562-mod5-rg-01"
    location = "EastUS"
    tags     = { Creator = "bibarys_mukhambetiyar@epam.com" }
  }
  rg2 = {
    name     = "cmaz-cc456562-mod5-rg-02"
    location = "WestUS"
    tags     = { Creator = "bibarys_mukhambetiyar@epam.com" }
  }
  rg3 = {
    name     = "cmaz-cc456562-mod5-rg-03"
    location = "WestEurope"
    tags     = { Creator = "bibarys_mukhambetiyar@epam.com" }
  }
}

app_service_plans = {
  asp1 = {
    name               = "cmaz-cc456562-mod5-asp-01"
    sku_tier           = "PremiumV3"
    sku_size           = "P0v3" # Per task parameter
    worker_count       = 2
    resource_group_key = "rg1"
    tags               = { Creator = "bibarys_mukhambetiyar@epam.com" }
  }
  asp2 = {
    name               = "cmaz-cc456562-mod5-asp-02"
    sku_tier           = "PremiumV3"
    sku_size           = "P1v3"
    worker_count       = 1
    resource_group_key = "rg2"
    tags               = { Creator = "bibarys_mukhambetiyar@epam.com" }
  }
}

app_services = {
  app1 = {
    name                 = "cmaz-cc456562-mod5-app-01"
    resource_group_key   = "rg1"
    app_service_plan_key = "asp1"
    tags                 = { Creator = "bibarys_mukhambetiyar@epam.com" }
  }
  app2 = {
    name                 = "cmaz-cc456562-mod5-app-02"
    resource_group_key   = "rg2"
    app_service_plan_key = "asp2"
    tags                 = { Creator = "bibarys_mukhambetiyar@epam.com" }
  }
}

traffic_manager = {
  name               = "cmaz-cc456562-mod5-traf"
  resource_group_key = "rg3"
  routing_method     = "Performance"
  tags               = { Creator = "bibarys_mukhambetiyar@epam.com" }
}
