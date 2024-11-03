data keycloak_realm "default" {
  realm = "default"
}

resource "keycloak_openid_client" "openid_client" {
  realm_id              = data.keycloak_realm.default.id
  client_id             = "grafana"
  name                  = "grafana"
  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = true
  implicit_flow_enabled = false
  direct_access_grants_enabled = true
  root_url = var.values.url
  admin_url = var.values.url
  web_origins = [var.values.url]
  base_url = var.values.url
  valid_redirect_uris   = [
    "${var.values.grafana.url}/login/generic_oauth",
    "https://oauth.pstmn.io/v1/callback"
  ]
  valid_post_logout_redirect_uris = [
    "${var.values.grafana.url}/login"
  ]
}

resource "keycloak_role" "client_role" {
  for_each = tomap({
    superadmin = "Super Admin"
    admin        = "Admin"
    editor       = "Editor"
    viewer       = "Viewer"
  })

  realm_id              = data.keycloak_realm.default.id
  client_id   = keycloak_openid_client.openid_client.id
  name        = each.key
  description = each.value
}

output "client-secret" {
  sensitive = true
  value     = keycloak_openid_client.openid_client.client_secret
}

output "client-id" {
  sensitive = true
  value     = keycloak_openid_client.openid_client.client_id
}