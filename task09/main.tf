module "afw" {
  source              = "./modules/afw"
  unique_id           = var.unique_id
  location            = local.rg_location
  rg_name             = local.rg_name
  vnet_name           = local.vnet_name
  vnet_space          = var.vnet_space
  subnet_name         = var.subnet_name
  subnet_space        = var.subnet_space
  aks_loadbalancer_ip = var.aks_loadbalancer_ip
}


