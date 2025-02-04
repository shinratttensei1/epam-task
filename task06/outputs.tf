output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = module.sql.sql_server_fqdn
}

output "app_hostname" {
  description = "The default hostname for the App Service."
  value       = module.webapp.app_hostname
}