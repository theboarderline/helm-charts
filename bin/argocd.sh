#!/bin/zsh

helm upgrade -i platform-cd \
walker-charts/argocd-platform \
-n platform-system --create-namespace \
-f ./argocd/values/$LIFECYCLE.yaml --dry-run
