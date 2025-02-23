resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  ip_address_type     = "Public"
  dns_name_label      = var.dns_name_label
  os_type             = "Linux"
  sku                 = "Standard"

  image_registry_credential {
    username = var.container_registry_username
    password = var.container_registry_pass
    server   = var.container_registry_server
  }

  container {
    name   = var.aci_name
    image  = "${var.container_registry_server}/${var.image_name}:latest"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }

    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "rue"
    }

    secure_environment_variables = {
      REDIS_URL = var.redis_hostname
      REDIS_PWD = var.redis_primary_key
    }
  }

  tags = var.tags
}
