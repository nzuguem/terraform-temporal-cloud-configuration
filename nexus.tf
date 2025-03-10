resource "temporalcloud_nexus_endpoint" "nexus_endpoints" {
  for_each    = { for nexus_endpoint in local.nexus_endpoints : nexus_endpoint.name => nexus_endpoint }
  name        = each.value.name
  description = each.value.description
  worker_target = {
    namespace_id = each.value.target_ns
    task_queue   = each.value.target_task_queue
  }
  allowed_caller_namespaces = each.value.callers_namespaces
}