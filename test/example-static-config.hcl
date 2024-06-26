
auto_auth {

  method {
    type = "token_file"

    config {
      token_file_path = "/Users/guybarros/.vault-token"
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
  command                   = ["psql", "", "arg1", "arg2"]
  restart_on_secret_changes = "always"
  restart_stop_signal       = "SIGTERM"
}
