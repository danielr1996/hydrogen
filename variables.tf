variable "values" {
  type = object({
    cluster = object({
      name = string
      # if true, write the outputs directly to files
      writefiles = bool
    })
    hcloud = object({
      k8stoken = string
      tofutoken = string
    })
  })
}

locals  {
  privatekeytemp = "default"
}