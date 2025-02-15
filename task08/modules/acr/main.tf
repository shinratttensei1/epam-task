resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = var.acr_sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "acr_task" {
  name                 = "example-task"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "https://github.com/your-repo.git"
    context_access_token = var.git_pat
    image_names          = ["${azurerm_container_registry.acr.login_server}/your-image:latest"]
    push_enabled         = true
  }

  source_trigger {
    name           = "source-trigger"
    events         = ["commit"]
    repository_url = "https://github.com/your-repo.git"
    source_type    = "GitHub"

    authentication {
      token     = var.git_pat
      token_type = "PAT"
    }
  }
}
