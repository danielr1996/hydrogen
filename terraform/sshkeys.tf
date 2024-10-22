
/**
Generates an ssh key for the nodes
**/
resource "tls_private_key" "sshkey" {
  algorithm = "ED25519"
}

resource "hcloud_ssh_key" "default" {
  name       = "default"
  public_key = tls_private_key.sshkey.public_key_openssh
}

output "sshkey" {
  value = tls_private_key.sshkey.private_key_openssh
  sensitive = true
}