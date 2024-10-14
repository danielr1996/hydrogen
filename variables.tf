variable "values" {
  type = object({
    cluster = object({
      name = string
    })
    hcloud = object({
      k8stoken = string
      tofutoken = string
    })
  })
}