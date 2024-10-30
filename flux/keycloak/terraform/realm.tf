resource "keycloak_realm" "default" {
  realm             = "default"
  enabled           = true
  display_name      = "Default"
  display_name_html = "Default"
  login_theme       = "keycloak"

  # TODO: mail doesnt work
#  smtp_server {
#    host = "smtp.ionos.de"
#    port = "465"
#    from = ""
#
#    auth {
#      username = ""
#      password = ""
#    }
#  }

  # TODO: Test if and how webauthn / passkeys works with keycloak
#  web_authn_policy {
#    relying_party_entity_name = "login.homelab.danielrichter.codes"
#    relying_party_id          = "login.homelab.danielrichter.codes"
#    signature_algorithms      = ["ES256", "RS256"]
#  }
}