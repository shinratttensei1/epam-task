resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = local.rg_location

  tags = var.tags
}

module "afw" {
  source        = "./modules/afw"
  unique_id     = var.unique_id
  location      = local.rg_location
  rg_name       = local.rg_name
  vnet_name     = local.vnet_name
  vnet_space    = var.vnet_space
  subnet_name   = var.subnet_name
  subnet_space  = var.subnet_space
  LB_IP_ADDRESS = var.LB_IP_ADDRESS
}


