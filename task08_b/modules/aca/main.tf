data "azurerm_client_config" "current" {}

# ----------------------
# Log Analytics Workspace for ACA Monitoring
# ----------------------
resource "azurerm_log_analytics_workspace" "aca_logs" {
  name                = "${var.aca_name}-logs"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# ----------------------
# User-Assigned Identity for ACA
# ----------------------
resource "azurerm_user_assigned_identity" "aca_identity" {
  name                = "${var.aca_name}-identity"
  resource_group_name = var.resource_group
  location            = var.location
}

# ----------------------
# Key Vault Access Policy for ACA
# ----------------------
resource "azurerm_key_vault_access_policy" "aca_kv_policy" {
  key_vault_id = var.keyvault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.aca_identity.principal_id

  secret_permissions = ["Get", "List"]
}

# ----------------------
# Azure Container App Environment (ACAE)
# ----------------------
resource "azurerm_container_app_environment" "acae" {
  name                       = var.aca_env_name
  resource_group_name        = var.resource_group
  location                   = var.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aca_logs.id
}

# ----------------------
# Azure Container App (ACA)
# ----------------------
resource "azurerm_container_app" "aca" {
  name                         = var.aca_name
  resource_group_name          = var.resource_group
  container_app_environment_id = azurerm_container_app_environment.acae.id
  revision_mode                = "Single"


  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aca_identity.id]
  }

  registry {
    server = var.acr_login_server
    identity = azurerm_user_assigned_identity.aca_identity.id
  }

  ingress {
    external_enabled = true
    target_port      = 5000
    transport        = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    min_replicas = 1
    max_replicas = 3  # Auto Scaling Handles More Load

    container {
      name   = "app"
      image  = "${var.acr_login_server}/${var.docker_image_name}:latest"
      cpu    = 0.50
      memory = "1.0Gi"

      env {
        name  = "CREATOR"
        value = "ACA"
      }

      env {
        name  = "REDIS_PORT"
        value = "6379"
      }

      env {
        name        = "REDIS_URL"
        secret_name = "redis-url"
      }

      env {
        name        = "REDIS_PWD"
        secret_name = "redis-password"
      }
    }

    custom_scale_rule {
      name            = "http-scale-rule"
      custom_rule_type = "http"

      metadata = {
        concurrentRequests = "50"
      }
    }

    custom_scale_rule {
      name            = "tcp-scale-rule"
      custom_rule_type = "tcp"

      metadata = {
        concurrentConnections = "20"
      }
    }
  }

  secret {
    name                = "redis-url"
    key_vault_secret_id = var.redis_url_secret_id
    identity            = azurerm_user_assigned_identity.aca_identity.id
  }

  secret {
    name                = "redis-password"
    key_vault_secret_id = var.redis_password_secret_id
    identity            = azurerm_user_assigned_identity.aca_identity.id
  }

  depends_on = [azurerm_role_assignment.aca_acr_pull] 
}

resource "azurerm_role_assignment" "aca_acr_pull" {
  scope                = var.acr_id_scope
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aca_identity.principal_id
}
