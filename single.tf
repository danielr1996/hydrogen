resource "hcloud_server" "single" {
  name        = "single"
  server_type = "cax21"
  location    = "nbg1"
  image       = "ubuntu-24.04"
  ssh_keys    = [hcloud_ssh_key.default.id]
}