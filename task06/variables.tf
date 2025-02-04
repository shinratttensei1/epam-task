variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
}


variable "existingkv_rgname" {
  description = "The name of the Resource Group in which the existing Key Vault is located."
  type        = string
}

variable "existingkv_name" {
  description = "The name of the existing Key Vault."
  type        = string
}

variable "kv_secret_name_for_sql_admin_name" {
  description = "The name of the secret in the Key Vault that stores the SQL Server admin name."
  type        = string
}

variable "kv_secret_name_for_sql_admin_password" {
  description = "The name of the secret in the Key Vault that stores the SQL Server admin password."
  type        = string
}

variable "sql_db_sm" {
  description = "The service objective name for the SQL Database."
  type        = string
}

variable "sql_server_fw_rulename" {
  description = "The name of the firewall rule for the SQL Server."
  type        = string
}


variable "asp_sku" {
  description = "The SKU of the App Service Plan."
  type        = string
}

variable "app_dotnet_version" {
  description = "The version of the .NET runtime."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
}

variable "verification_agent_ip" {
  description = "The IP address of the verification agent."
  type        = string
}

variable "allowed_ip_address" {
  description = "The IP address to allow in the SQL Server firewall."
  type        = string
}