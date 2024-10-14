output "k0sctl" {
  value = yamlencode({
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
            keyPath = "default",
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