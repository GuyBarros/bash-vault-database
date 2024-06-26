resource "vault_mount" "postgres" {
  path     = "postgres"
  type     = "database"
}
resource "vault_database_secret_backend_connection" "postgres-con" {
  backend       = vault_mount.postgres.path
  name          = "postgres-con"
  allowed_roles = ["postgres-role"]
  postgresql {
    connection_url       = "postgres://{{username}}:{{password}}@${data.aws_db_instance.postgres.endpoint}/${data.aws_db_instance.postgres.db_name}" #?sslmode=disable"
    max_open_connections = -1
    username = data.aws_db_instance.postgres.master_username
    password = var.postgres_password
  }
}


resource "vault_database_secret_backend_role" "postgres-role" {
  depends_on          = [vault_database_secret_backend_connection.postgres-con]
  backend             = vault_mount.postgres.path
  name                = "postgres-role"
  db_name             = vault_database_secret_backend_connection.postgres-con.name
  creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"]
  revocation_statements = [
    "REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM \"{{name}}\";",
    "DROP USER \"{{name}}\";",
  ]

}
