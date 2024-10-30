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
  username  = var.values.username
  password  = var.values.password
  url       = "${var.values.scheme}${var.values.url}"
}