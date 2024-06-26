terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
     # version = "~> 2.24"
    }
  }
}

# Configure the Okta Provider

provider "vault" {
   # address = var.vault_addr
  # namespace= var.vault_namespace
  # token = "<your token here> or set as VAULT_TOKEN env var"

  # use admin namespace for HCP Vault
  # namespace = "admin"
}

provider "aws"{

  region = var.region
}