
/**
Accepts a list of ip addresses for which the ssh hostkeys are refreshed on the machine executing tofu
**/
locals {
  hostkeys = [hcloud_server.single.ipv4_address]
}

resource "terraform_data" "updatehostkeys" {
  count = 0
  provisioner "local-exec" {
    command     = <<-EOF
      touch $HOME/.ssh/known_hosts
      %{ for ip in  local.hostkeys}
      ssh-keygen -R ${ip}
      ssh-keyscan -H ${ip} >> $HOME/.ssh/known_hosts
      %{ endfor }
      exit 0
    EOF
    interpreter = ["bash", "-c"]
  }
}