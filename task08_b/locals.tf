locals {
  prefix = var.namespace_prefix

  aca_name       = "cmtr-cc456562-mod8b-ca"
  aca_env_name   = "cmtr-cc456562-mod8b-cae"
  acr_name       = "cmtrcc456562mod8bcr"
  aks_name       = "cmtr-cc456562-mod8b-aks"
  keyvault_name  = join("-", [local.prefix, "kv"])
  redis_aci_name = join("-", [local.prefix, "redis-ci"])
  rg_name        = join("-", [local.prefix, "rg"])
  location       = "eastus2"
  sa_name        = "cmtrcc456562mod8bsa"
  aks_dns_name   = "cmtr-cc456562-mod8b-aks-dns"
}

