data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "${var.aks_name}-identity"
  resource_group_name = var.rg_name
  location            = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = "cmtr-cc456562-mod8b-aks-dns"

  default_node_pool {
    name            = var.node_pool_name
    node_count      = var.node_pool_count
    vm_size         = var.node_pool_vm_size
    os_disk_type    = var.node_pool_os_disk_type
    os_disk_size_gb = 64
}

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  network_profile {
    network_plugin    = "azure"
    }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
}



resource "azurerm_key_vault_access_policy" "aks_kv_access" {
  key_vault_id = var.keyvault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = ["Get", "List"]
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id_scope
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}


