locals {
  prefix = "cmaz-cc456562-mod6"

  rg_name          = format("%s-rg", local.prefix)
  sql_server_name  = format("%s-sql", local.prefix)
  sql_db_name      = format("%s-sql-db", local.prefix)
  asp_name         = format("%s-asp", local.prefix)
  app_name         = format("%s-app", local.prefix)
}
