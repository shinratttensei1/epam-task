variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group in which all resources will be created."
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_db_name" {
  description = "The name of the SQL Database."
  type        = string
}

variable "sql_db_sm" {
  description = "The service objective for the SQL Database."
  type        = string
}

variable "sql_server_fw_rulename" {
  description = "The name of the SQL Server Firewall Rule."
  type        = string
}

variable "kv_secret_name_for_sql_admin_name" {
  description = "The name of the Key Vault secret for the SQL Server admin name."
  type        = string
}

variable "kv_secret_name_for_sql_admin_password" {
  description = "The name of the Key Vault secret for the SQL Server admin password."
  type        = string
}

variable "verification_agent_ip" {
  description = "Verification agent IP address allowed in Web App access restrictions."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Tenant ID."
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

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
}

variable "allowed_ip_address" {
  description = "The IP address that should be allowed to access the SQL Server."
  type        = string
}

