# Initialize a cluster

```shell
cat > main.tf <<EOF
module "cluster" {
  source = "github.com/danielr1996/hydrogen"
  values = {
    hcloud = {
      tofutoken="$TOFUTOKEN"
      k8stoken="$K8STOKEN"
    }
    cluster = {
      name = "$NAME"
    }
  }
}

output "sshkey" {
  sensitive = true
  value = module.cluster.sshkey
}

output "k0sctl" {
  sensitive = false
  value = module.cluster.k0sctl
}

output "kubeconfig" {
  sensitive = true
  value     = module.cluster.kubeconfig
}
EOF
```

```shell
tofu init
tofu apply -auto-approve
tofu output --raw kubeconfig > $KUBECONFIG
```