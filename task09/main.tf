data "azurerm_resource_group" "existing_rg" {
  name = local.rg_name
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = local.vnet_name
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

module "afw" {
  source              = "./modules/afw"
  unique_id           = var.unique_id
  location            = data.azurerm_resource_group.existing_rg.location
  rg_name             = data.azurerm_resource_group.existing_rg.name
  vnet_name           = data.azurerm_virtual_network.existing_vnet.name
  vnet_space          = var.vnet_space
  subnet_name         = var.subnet_name
  subnet_space        = var.subnet_space
  aks_loadbalancer_ip = var.aks_loadbalancer_ip
}


