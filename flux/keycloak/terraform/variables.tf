variable "values" {
  type = object({
    username = string
    password = string
    url = string
    scheme = string
  })
}
