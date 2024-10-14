# Initialize a cluster

```shell
INSTANCE=dev
WORKDIR="../hydrogen-instances/$INSTANCE"
cd $WORKDIR
source .envrc
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
EOF
tofu init
```

```shell
tofu apply -auto-approve
```

```shell
tofu output --raw k0sctl > k0sctl.yaml 
tofu output --raw sshkey > default 
chmod 0600 default
```

```shell
k0sctl apply
k0sctl kubeconfig > ~/.kube/my-cluster
```