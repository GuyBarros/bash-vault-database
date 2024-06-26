resource "vault_auth_backend" "cert" {
    path = "cert"
    type = "cert"
}

resource "vault_cert_auth_backend_role" "cert" {
    name           = "admin"
    certificate    = vault_pki_secret_backend_root_sign_intermediate.int_ca.certificate
    backend        = vault_auth_backend.cert.path
    allowed_common_names  = ["foo.example.org", "baz.example.org"]
    token_ttl      = 300
    token_max_ttl  = 600
    token_policies = ["admin-policy"]
}