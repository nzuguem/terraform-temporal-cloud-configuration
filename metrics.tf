resource "tls_private_key" "ca_metrics_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "ca_metrics_cert" {
  private_key_pem = tls_private_key.ca_metrics_private_key.private_key_pem
  allowed_uses = [
    "cert_signing",
    "server_auth",
    "client_auth",
  ]
  subject {
    common_name  = "Metrics CA Root"
    organization = "nzuguem"
  }
  validity_period_hours = 8760
  is_ca_certificate     = true
}

resource "tls_private_key" "client_metrics_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_cert_request" "client_metrics_cert_request" {
  private_key_pem = tls_private_key.client_metrics_private_key.private_key_pem
  dns_names       = []
  subject {
    common_name  = "Metrcis Client"
    organization = "nzuguem"
  }
}

resource "tls_locally_signed_cert" "client_metrics_cert" {
  cert_request_pem      = tls_cert_request.client_metrics_cert_request.cert_request_pem
  ca_private_key_pem    = tls_private_key.ca_metrics_private_key.private_key_pem
  ca_cert_pem           = tls_self_signed_cert.ca_metrics_cert.cert_pem
  validity_period_hours = 8760
  allowed_uses = [
    "client_auth",
    "digital_signature"
  ]
  is_ca_certificate = false
}

resource "temporalcloud_metrics_endpoint" "metrics_endpoint" {
  accepted_client_ca = base64encode(tls_self_signed_cert.ca_metrics_cert.cert_pem)
}