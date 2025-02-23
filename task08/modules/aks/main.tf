resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "${var.aks_name}-identity"
  resource_group_name = var.rg_name
  location            = var.rg_location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  network_profile {
    network_plugin = "azure"

  }

  default_node_pool {
    name            = "system"
    node_count      = var.node_count
    vm_size         = var.vm_size
    os_disk_type    = var.os_disk_type
    os_disk_size_gb = 64
  }

  storage_profile {
    file_driver_enabled = true
    disk_driver_enabled = true
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}

