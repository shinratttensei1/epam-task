data "azurerm_subnet" "aks_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

resource "azurerm_subnet" "afw_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet_space]
}

resource "azurerm_public_ip" "afw_pip" {
  name                = local.afw_pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "afw" {
  name                = local.afw_name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.afw_subnet.id
    public_ip_address_id = azurerm_public_ip.afw_pip.id
  }
}

resource "azurerm_route_table" "afw_rt" {
  name                = local.afw_rt_name
  location            = var.location
  resource_group_name = var.rg_name

  route {
    name                   = "to-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.afw.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "afw_rt_assoc" {
  subnet_id      = azurerm_subnet.afw_subnet.id # ✅ FIXED
  route_table_id = azurerm_route_table.afw_rt.id
}

resource "azurerm_firewall_application_rule_collection" "afw_app_rule" {
  name                = local.app_rules_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 100
  action              = "Allow"

  rule {
    name             = "AllowNGINX"
    source_addresses = ["*"]
    target_fqdns     = ["*"]
    protocol {
      port = 80
      type = "Http"
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "afw_network_rule" {
  name                = local.afw_network_rule_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 200
  action              = "Allow"

  dynamic "rule" {
    for_each = {
      "AllowDNS" = { destination_addresses = ["168.63.129.16"], protocols = ["UDP"], destination_ports = ["53"] },
      "AllowWeb" = { destination_addresses = ["*"], protocols = ["TCP"], destination_ports = ["443", "80"] }
    }
    content {
      name                  = rule.key
      source_addresses      = ["*"]
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}

resource "azurerm_firewall_nat_rule_collection" "afw_nat_rule" {
  name                = local.afw_nat_rule_name
  azure_firewall_name = azurerm_firewall.afw.name
  resource_group_name = var.rg_name
  priority            = 300
  action              = "Dnat"

  dynamic "rule" {
    for_each = {
      "nginx" = { port = 80, translated_address = var.aks_loadbalancer_ip }
    }
    content {
      name                  = rule.key
      source_addresses      = ["*"]
      destination_addresses = [azurerm_public_ip.afw_pip.ip_address]
      destination_ports     = [rule.value.port]
      translated_address    = rule.value.translated_address
      translated_port       = rule.value.port # ✅ FIXED TRANSLATED PORT
      protocols             = ["TCP"]
    }
  }
}
