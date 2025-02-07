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

resource "local_file" "grafana_datasources_config" {
  filename = "${path.module}/grafana/datasources.yaml"
  content = templatefile("${path.module}/datasources.yaml.tftpl", {
    metrics_uri         = temporalcloud_metrics_endpoint.metrics_endpoint.uri
    client_metrics_cert = tls_locally_signed_cert.client_metrics_cert.cert_pem
    client_metrics_private_key = tls_private_key.client_metrics_private_key.private_key_pem
  })
}