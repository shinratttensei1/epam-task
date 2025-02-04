output "web_app_url" {
  value = module.webapp.app_hostname
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = module.sql.sql_server_fqdn
}

output "sql_connection_string" {
  description = "The SQL connection string for the Web App"
  value       = module.sql.sql_connection_string
  sensitive   = true
}

output "app_hostname" {
  description = "The default hostname for the Web App"
  value       = module.webapp.app_hostname
}
