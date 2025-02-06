locals {
  config = yamldecode(file("${path.module}/${var.config_file}"))

  namespaces = local.config.namespaces
  custom_search_attributes = flatten([
    for ns in local.namespaces : [
      for csa in try(ns.custom_search_attributes, []) : {
        ns_name = ns.name
        ns_id   = temporalcloud_namespace.namespaces[ns.name].id
        name    = csa.name
        type    = csa.type
      }
    ]
  ])

  users = [
    for identity in local.config.identities : identity
    if identity.type == "user"
  ]
  users_without_or_implicit_ns_accesses = [
    for user in local.users : user
    if user.roles.global == "admin" || user.roles.namespaces == null
  ]
  users_with_explicit_ns_accesses = [
    for user in local.users : user
    if user.roles.global != "admin" && user.roles.namespaces != null
  ]

  service_accounts = [
    for identity in local.config.identities : identity
    if identity.type == "sa"
  ]
  sa_without_or_implicit_ns_accesses = [
    for sa in local.service_accounts : sa
    if sa.roles.global == "admin" || sa.roles.namespaces == null
  ]
  service_accounts_with_explicit_ns_accesses = [
    for sa in local.service_accounts : sa
    if sa.roles.global != "admin" && sa.roles.namespaces != null
  ]

  service_accounts_with_api_keys = [
    for sa in local.service_accounts : sa
    if try(sa.api_key.generate, false) == true
  ]

  identities_namespace_accesses = {
    for identity in local.config.identities :
    identity.id => flatten([
      for ns_name, role in try(identity.roles.namespaces, {}) : {
        namespace_id = temporalcloud_namespace.namespaces[ns_name].id
        permission   = role
      }
    ])
  }
}