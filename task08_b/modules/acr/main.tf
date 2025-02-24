
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true  # Enable admin access (optional)
}

resource "azurerm_container_registry_task" "acr_task" {
  name                = "build-app-image"
  container_registry_id = azurerm_container_registry.acr.id

  platform {
    os = "Linux"
  }

  
  docker_step {
    dockerfile_path = "Dockerfile"
    context_path    = "https://${var.storage_account_name}.blob.core.windows.net/${var.storage_container_name}/${var.storage_blob_name}?${var.sas_token}"
    image_names     = ["${var.docker_image_name}:latest"]
    push_enabled    = true
    context_access_token = var.sas_token
  }
  
}

resource "azurerm_container_registry_task_schedule_run_now" "acr_task_schedule" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id
}
