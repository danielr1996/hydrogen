locals{
  k0sctl = yamlencode({
    apiVersion = "k0sctl.k0sproject.io/v1beta1"
    kind       = "Cluster"
    metadata = {
      name = var.values.cluster.name
    }
    spec = {
      hosts = [
        {
          role         = "single"
          installFlags = [
            "--enable-cloud-provider",
            "--kubelet-extra-args=--cloud-provider=external",
            "--kubelet-extra-args=--node-ip=${hcloud_server.single.ipv4_address}"]
          openSSH = {
            address = hcloud_server.single.ipv4_address,
            user    = "root",
            port    = 22,
            keyPath = local.privatekeytemp,
          }
        }
      ],
      k0s = {
        config = {
          spec = {
            network= {
              provider= "calico"
              kubeProxy= {
                mode= "ipvs"
              }
            }
            api = {
              #              externalAddress = hcloud_load_balancer.controller.ipv4,
              #              sans= [hcloud_load_balancer.controller.ipv4]
            },
            extensions= {
              helm = {
                repositories = concat(
                  local.extensions.hcloud.repos,
                  local.extensions.gitops.repos
                )
                charts = concat(
                  local.extensions.hcloud.charts,
                  local.extensions.gitops.charts
                )
              }
            }
          }
        }
      }
    }
  })
}

#output "k0sctl" {
#  value = local.k0sctl
#}

resource "local_sensitive_file" "sshkey" {
  content  = tls_private_key.sshkey.private_key_openssh
  filename = local.privatekeytemp
}

resource "local_file" "k0sctl" {
  content  = local.k0sctl
  filename = "k0sctl.yaml"
}

resource "terraform_data" "cluster" {
  triggers_replace = local.k0sctl
  depends_on = [local_sensitive_file.sshkey, local_file.k0sctl]
  provisioner "local-exec" {
    command     = <<-EOF
      %{ if var.values.hack.updateknownhosts}
      %{ for ip in  [hcloud_server.single.ipv4_address]}
      ssh-keygen -R ${ip}
      ssh-keyscan -H ${ip} >> $HOME/.ssh/known_hosts
      %{ endfor }
      %{ endif }
      k0sctl apply
    EOF
    interpreter = ["sh", "-c"]
  }
}

output "kubeconfig" {
  value = base64decode(data.external.kubeconfig.result.kubeconfig)
  sensitive = true
}

data "external" "kubeconfig" {
  depends_on = [terraform_data.cluster, local_sensitive_file.sshkey, local_file.k0sctl]
  program = ["sh", "${path.module}/bootstrap_k0s.sh"]
}