resource "vault_identity_group" "vault-admins" {
  name     = "vault-admins"
  type     = "external"
  policies = ["admin-policy"]

  metadata = {
    version = "1"
  }
}

resource "vault_identity_group_alias" "vault-admins-group-alias" {
  name           = "vault-2-admins"
  mount_accessor = vault_jwt_auth_backend.okta_oidc.accessor
  canonical_id   = vault_identity_group.vault-admins.id
}

resource "vault_identity_group" "vault-devs" {
  name     = "vault-devs"
  type     = "external"
  policies = ["devs-policy"]

  metadata = {
    version = "1"
  }
}

resource "vault_identity_group_alias" "vault-devs-group-alias" {
  name           = "vault-2-devs"
  mount_accessor = vault_jwt_auth_backend.okta_oidc.accessor
  canonical_id   = vault_identity_group.vault-devs.id
}