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
      k8stoken = string
      tofutoken = string
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