resource "random_password" "redis_password" {
  length  = 16
  special = true
}

resource "azurerm_container_group" "redis" {
  name                = var.redis_aci_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"

  container {
    name   = "redis"
    image  = "mcr.microsoft.com/cbl-mariner/base/redis:6.2" # Using Microsoft Artifact Registry
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 6379
      protocol = "TCP"
    }

    environment_variables = {
      REDIS_PASSWORD = random_password.redis_password.result
    }

    commands = [
      "redis-server", 
      "--protected-mode", "no",
      "--requirepass", random_password.redis_password.result
    ]
  }

  dns_name_label = var.redis_aci_dns_name
  ip_address_type = "Public"
}

