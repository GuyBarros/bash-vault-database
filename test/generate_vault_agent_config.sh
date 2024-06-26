export VAULT_ADDR="https://127.0.0.1:8200"
export VAULT_TOKEN="root"

#Dynamic
vault agent generate-config \
         -type="env-template" \
         -exec="psql  arg1 arg2" \
         -path="postgres/creds/postgres-role" \
         example-dynamic-config.hcl

#Static
vault agent generate-config \
         -type="env-template" \
         -exec="psql  arg1 arg2" \
         -path="secret/foo" \
         example-static-config.hcl


# run vault agent
vault agent -config=cert-static-config.hcl -log-level=error -log-file=./vault-agent.log # -exit-after-auth