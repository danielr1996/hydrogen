variable "values" {
  type = object({
    keycloak = object({
      username = string
      password = string
      url = string
      scheme = string
    })
    grafana = object({
      url = string
    })
  })
}
