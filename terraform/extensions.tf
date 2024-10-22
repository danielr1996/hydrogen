locals {
  extensions = {
    gitops = {
      repos = [
        {
          name = "fluxcd-community",
          url  = "https://fluxcd-community.github.io/helm-charts"
        },
        {
          name = "tf-controller",
          url  = "https://flux-iac.github.io/tofu-controller"
        }
      ]
      charts = [
        {
          name      = "flux2"
          chartname = "fluxcd-community/flux2"
          version   = "2.13.0"
          namespace = "flux-system"
          values    = ""
        },
        {
          name      = "flux2-sync"
          chartname = "fluxcd-community/flux2-sync"
          version   = "1.10.0"
          namespace = "flux-system"
          values    = <<EOF
                      secret:
                        create: true
                        data:
                          username: ${var.values.flux.username}
                          password: ${var.values.flux.password}
                      gitRepository:
                        spec:
                          url: ${var.values.flux.url}
                          ref:
                            branch: ${var.values.flux.branch}
                      kustomization:
                        spec:
                          path: ${var.values.flux.path}
          EOF
        },
        {
          name      = "tf-controller"
          chartname = "tf-controller/tf-controller"
          version   = "0.15.1"
          namespace = "flux-system"
          values    = <<EOF
            allowBreakTheGlass: true
          EOF
        }
      ]
    }
    hcloud = {
      repos = [
        {
          name = "hcloud",
          url  = "https://charts.hetzner.cloud"
        }
      ]
      charts = [
        {
          order     = -1
          name      = "hetzner-ccm-secrets"
          chartname = "oci://ghcr.io/danielr1996/secret"
          version   = "1.0.0"
          namespace = "kube-system"
          values    = <<EOF
            name: hcloud
            values:
              token: ${var.values.hcloud.token}
          EOF
        },
        {
          order     = -2
          name      = "hetzner-ccm"
          chartname = "hcloud/hcloud-cloud-controller-manager"
          version   = "1.20.0"
          namespace = "kube-system"
          values    = ""
        },
        {
          name      = "hetzner-csi"
          chartname = "hcloud/hcloud-csi"
          version   = "2.9.0"
          namespace = "kube-system"
          values    = <<EOF
            node:
              kubeletDir: /var/lib/k0s/kubelet
          EOF
        }
      ]
    }
  }
}