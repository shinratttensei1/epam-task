output "traffic_manager_fqdn" {
  description = "The FQDN of the Azure Traffic Manager Profile"
  value       = module.traffic_manager.traffic_manager_fqdn
}
