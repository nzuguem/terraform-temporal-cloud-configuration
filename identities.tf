resource "temporalcloud_user" "users_without_or_implicit_ns_accesses" {
  for_each       = { for user in local.users_without_or_implicit_ns_accesses : user.id => user }
  email          = each.value.id
  account_access = each.value.roles.global
}

resource "temporalcloud_user" "users_with_explicity_ns_accesses" {
  for_each           = { for user in local.users_with_explicit_ns_accesses : user.id => user }
  email              = each.value.id
  account_access     = each.value.roles.global
  namespace_accesses = local.identities_namespace_accesses[each.key]
}

resource "temporalcloud_service_account" "sa_without_or_implicit_ns_accesses" {
  for_each       = { for sa in local.sa_without_or_implicit_ns_accesses : sa.id => sa }
  name           = each.value.id
  account_access = each.value.roles.global
}

resource "temporalcloud_service_account" "service_accounts_with_explicit_ns_accesses" {
  for_each           = { for sa in local.service_accounts_with_explicit_ns_accesses : sa.id => sa }
  name               = each.value.id
  account_access     = each.value.roles.global
  namespace_accesses = local.identities_namespace_accesses[each.key]
}

resource "temporalcloud_apikey" "api_keys" {
  for_each     = { for sa in local.service_accounts_with_api_keys : sa.id => sa }
  display_name = each.value.id
  owner_type   = "service-account"
  owner_id     = try(temporalcloud_service_account.service_accounts_with_explicit_ns_accesses[each.key].id, temporalcloud_service_account.sa_without_or_implicit_ns_accesses[each.key].id)
  expiry_time  = each.value.api_key.expiry_time
  disabled     = false
}