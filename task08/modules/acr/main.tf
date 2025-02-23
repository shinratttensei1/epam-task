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

  docker_step {
    context_access_token = var.git_pat
    context_path         = "https://github.com/shinratttensei1/epam-task#main:task08/application"
    dockerfile_path      = "Dockerfile"
    image_names          = ["${var.image_name}:latest"]
    push_enabled         = true
  }
}


resource "azurerm_container_registry_task_schedule_run_now" "acr_task_run_now" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id

  depends_on = [azurerm_container_registry_task.acr_task]
}