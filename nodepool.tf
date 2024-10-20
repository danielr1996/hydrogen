locals {
  nodes = flatten([
    for k, v in var.values.cluster.nodepools : [
      for idx in range(v.count) :{
        role     = v.role
        name     = "${k}-${idx}"
        flavour  = v.flavour
        location = "nbg1"
        image    = "ubuntu-24.04"
      }
    ]
  ])
}

resource "hcloud_server" "nodepool" {
  for_each    = tomap({for k, v in local.nodes : v.name=>v})
  name        = each.value.name
  server_type = each.value.flavour
  location    = each.value.location
  image       = each.value.image
  ssh_keys    = [hcloud_ssh_key.default.id]
}