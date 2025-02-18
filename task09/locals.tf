locals {
    rg_name            = join("-", [var.unique_id, "rg"])
    rg_location        = "eastus2"
    vnet_name          = join("-", [var.unique_id, "vnet"])
}