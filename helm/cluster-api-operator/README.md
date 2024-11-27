# Updating

[//]: # (1. Pull upstream from https://github.com/kubernetes-sigs/cluster-api-operator/tree/main/hack/charts/cluster-api-operator)
1. helm pull capi-operator/cluster-api-operator
2. Move CRDs from templates/operator-components.yaml to crds/crds.yaml