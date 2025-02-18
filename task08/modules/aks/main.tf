resource "azurerm_user_assigned_identity" "aks_identity" {
  name = "${var.aks_name}-identity"
  resource_group_name = var.rg_name
  location = var.rg_location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }


  default_node_pool {
    name         = "default"
    node_count   = var.node_count
    vm_size      = var.vm_size
    os_disk_type = var.os_disk_type
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}


resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

resource "azurerm_key_vault_access_policy" "aks_kv_policy" {
  key_vault_id = var.kv_id
  tenant_id =   var.tenant
  object_id    = azurerm_user_assigned_identity.aks_identity.principal_id

  secret_permissions = [
    "Get",
    "List"
  ]
}