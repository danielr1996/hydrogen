variable "values" {
  type = object({
    keycloak = object({
      username = string
      password = string
      hostname = string
      scheme = string
    })
    grafana = object({
      hostname = string
      scheme = string
    })
  })
}
