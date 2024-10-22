variable "values" {
  type = object({
    cluster = object({
      name = string
      nodepools = map(object({
        count = number
        role = string
        flavour = string
      }))
    })
    hcloud = object({
      token = string
    })
    flux = object({
      username = string
      password = string
      url = string
      branch = string
      path = string
      suspend = bool
    })
  })
}

variable "writekubeconfig" {
  type = bool
  default = false
}

variable "updateknownhosts" {
  type = bool
  default = false
}

locals  {
  privatekeytemp = "default"
}