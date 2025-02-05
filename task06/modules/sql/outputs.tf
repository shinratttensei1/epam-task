output "sql_server_fqdn" {
  value = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_connection_string" {
  value = sensitive(join("", [
    "Server=", azurerm_mssql_server.sql_server.fully_qualified_domain_name, ";",
    "Database=", azurerm_mssql_database.sql_db.name, ";",
    "User ID=", azurerm_mssql_server.sql_server.administrator_login, ";",
    "Password=", random_password.password.result, ";",
    "Encrypt=True;",
    "TrustServerCertificate=False;",
    "Connection Timeout=30;"
  ]))
  sensitive = true
}


