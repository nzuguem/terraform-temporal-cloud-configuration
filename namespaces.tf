resource "temporalcloud_namespace" "namespaces" {
  for_each       = { for ns in local.namespaces : ns.name => ns }
  name           = each.value.name
  regions        = each.value.regions
  api_key_auth   = true
  retention_days = each.value.retention

  // Prevents Terraform from deleting namespace. Must remove this before destroying resource.
  //lifecycle {
  //   prevent_destroy = true
  // }
}

resource "temporalcloud_namespace_search_attribute" "search_attribute3" {
  for_each     = { for csa in local.custom_search_attributes : "${csa.ns_name}/${csa.name}" => csa }
  namespace_id = each.value.ns_id
  name         = each.value.name
  type         = each.value.type
}