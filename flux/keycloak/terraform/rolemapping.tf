data "keycloak_openid_client_scope" "roles" {
  realm_id = keycloak_realm.default.id
  name     = "roles"
}

resource "keycloak_openid_user_client_role_protocol_mapper" "rolemapper" {
  realm_id        = keycloak_realm.default.id
  client_scope_id = data.keycloak_openid_client_scope.roles.id
  name            = "client roles (id token)"
  claim_name      = "resource_access.$${client_id}.roles"
  add_to_id_token = true
  add_to_userinfo = true
  multivalued     = true
}