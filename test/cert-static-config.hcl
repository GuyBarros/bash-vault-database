
auto_auth {

  method {
    type = "cert"
    config {
      name = "admin"
      ca_cert = "/Users/guybarros/GIT_ROOT/bash-vault-database/test/issuing_ca.pem"
      client_cert = "/Users/guybarros/GIT_ROOT/bash-vault-database/test/client_cert.pem"
      client_key = "/Users/guybarros/GIT_ROOT/bash-vault-database/test/client_key.pem"
      reload = true
    }
  }
}

template_config {
  static_secret_render_interval = "5m"
  exit_on_retry_failure         = true
  max_connections_per_host      = 10
}

vault {
  address = "https://127.0.0.1:8200"
}

env_template "FOO_PASSWORD" {
  contents             = "{{ with secret \"secret/data/foo\" }}{{ .Data.data.password }}{{ end }}"
  error_on_missing_key = true
}
env_template "FOO_USER" {
  contents             = "{{ with secret \"secret/data/foo\" }}{{ .Data.data.user }}{{ end }}"
  error_on_missing_key = true
}

exec {
  command                   = ["./kv-demo.sh"]
  restart_on_secret_changes = "always"
  restart_stop_signal       = "SIGTERM"
}

exit_after_auth = true

