output "api_keys" {
  value     = { for name, api_key in temporalcloud_apikey.api_keys : name => api_key.token }
  sensitive = true
}

output "namespaces" {
  value = {
    for name, ns in temporalcloud_namespace.namespaces :
    name => {
      id           = ns.id
      grpc_address = ns.endpoints.grpc_address
    }
  }
}

output "metrics_endpoint" {
  value = temporalcloud_metrics_endpoint.metrics_endpoint.uri
}

resource "local_file" "client_cert" {
  content  = tls_locally_signed_cert.client_metrics_cert.cert_pem
  filename = "${path.module}/client_metrics_cert.pem"
}

resource "local_file" "client_private_key" {
  content  = tls_private_key.client_metrics_private_key.private_key_pem
  filename = "${path.module}/client_metrics_private_key.pem"
}

resource "local_file" "ca_metrics_cert" {
  content  = tls_self_signed_cert.ca_metrics_cert.cert_pem
  filename = "${path.module}/ca_metrics_cert.pem"
}