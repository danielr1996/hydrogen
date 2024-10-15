#!/bin/bash
set -e
PAYLOAD=$(k0sctl kubeconfig | base64)
jq -n --arg kubeconfig "$PAYLOAD" '{"kubeconfig":$kubeconfig}'
