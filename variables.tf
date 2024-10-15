variable "values" {
  type = object({
    cluster = object({
      name = string
    })
    hcloud = object({
      k8stoken = string
      tofutoken = string
    })
    hack = object({
      updateknownhosts = bool
    })
  })
}

locals  {
  privatekeytemp = "default"
}