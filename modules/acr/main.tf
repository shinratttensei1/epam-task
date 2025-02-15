resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = var.acr_sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "acr_task" {
  name                  = "${var.acr_name}-docker-image-build-task"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os = "Linux"
  }

  source_trigger {
    name           = "docker-image-build-trigger"
    enabled        = true
    source_type    = "GitHub"
    repository_url = var.git_repository_url
    branch         = var.git_repository_branch
    events         = ["push"]

  }

  docker_step {
    context_access_token = var.git_pat
    context_path         = "application"
    dockerfile_path      = "application/Dockerfile"
    image_names          = ["${var.image_name}:latest"]
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "acr_task_run_now" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id
}

