#!/bin/bash

# Configuration
CERT_ROLE="admin"
COMMON_NAME="foo.example.org"
TTL="24h"
INT_CA_PATH="int_ca/issue/leaf-ca"

# Export Vault address and token
export VAULT_ADDR
export VAULT_TOKEN

# Generate certificate from Vault
CERT_RESPONSE=$(vault write -format=json $INT_CA_PATH common_name=$COMMON_NAME ttl=$TTL)

# Remove control characters
CERT_RESPONSE=$(echo "$CERT_RESPONSE" | tr -d '\000-\037')

# Extract certificate details
CERTIFICATE=$(echo $CERT_RESPONSE | jq -r '.data.certificate')
PRIVATE_KEY=$(echo $CERT_RESPONSE | jq -r '.data.private_key')
ISSUING_CA=$(echo $CERT_RESPONSE | jq -r '.data.issuing_ca')

# Write the certificate and private key to files
echo "$CERTIFICATE" > client_cert.pem
echo "$PRIVATE_KEY" > client_key.pem
echo "$ISSUING_CA" > issuing_ca.pem

# Reauthenticate to Vault using certificate auth method
vault login -method=cert -ca-cert=issuing_ca.pem -client-cert=client_cert.pem -client-key=client_key.pem name=admin

