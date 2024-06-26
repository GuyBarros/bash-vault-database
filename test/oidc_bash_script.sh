POSTGRES_HOST="guystack-postgres.cwwnbexip9py.eu-west-2.rds.amazonaws.com"
POSTGRES_DATABASE="postgres"

vault login -method=oidc -path=okta_oidc




# Function to generate dynamic Postgres credentials from Vault
generate_postgres_creds() {
  TEMP_CREDS=$(vault read -format=json postgres/creds/postgres-role)
  if [ $? -ne 0 ]; then
    echo "Failed to generate Postgres credentials"
    exit 1
  fi

PGUSER=$(echo $TEMP_CREDS | jq -r '.data.username')
PGPASSWORD=$(echo $TEMP_CREDS | jq -r '.data.password')
}


# Function to login to Postgres using the generated credentials
login_postgres() {
   psql  -h "$POSTGRES_HOST" -d "$POSTGRES_DATABASE"
  if [ $? -ne 0 ]; then
    echo "Postgres login failed"
    exit 1
  fi
}

login_postgres