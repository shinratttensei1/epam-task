  output "app_hostname" {
    description = "The default hostname for the App Service."
    value       = azurerm_linux_web_app.webapp.default_hostname
  }