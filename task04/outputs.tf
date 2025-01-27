output "vm_public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "VM public IP"
}

output "vm_fqdn" {
  value       = azurerm_public_ip.pip.fqdn
  description = "Fully Qualified Domain Name of the Virtual Machine"
}
