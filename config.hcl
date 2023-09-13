ui = true

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 0
  tls_cert_file = "/vault/cert/localhost.crt"
  tls_key_file  = "/vault/cert/localhost.key"
}

storage "file" {
  path = "/vault/file"
}

api_addr = "http://127.0.0.1:8200"

disable_mlock = "true"