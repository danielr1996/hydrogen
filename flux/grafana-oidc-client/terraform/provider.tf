terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "4.4.0"
    }
  }
}

provider "keycloak" {
  client_id = "admin-cli"
  username  = var.values.keycloak.username
  password  = var.values.keycloak.password
  url       = "${var.values.keycloak.scheme}${var.values.keycloak.url}"
}