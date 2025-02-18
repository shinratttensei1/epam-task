locals {
  app_rules_name    = join("-", [var.unique_id, "afw-app-rules"])
  afw_rt_name       = join("-", [var.unique_id, "afw-rt"])
  afw_name          = join("-", [var.unique_id, "afw"])
  afw_pip_name      = join("-", [var.unique_id, "afw-pip"])
  afw_nat_rule_name = join("-", [var.unique_id, "afw-nat-rules"])
  rg_name           = join("-", [var.unique_id, "rg"])
  rg_location       = "eastus2"
  vnet_name         = join("-", [var.unique_id, "vnet"])
}
