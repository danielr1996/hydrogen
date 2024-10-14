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
k0sctl kubeconfig > ~/.kube/<name>
```