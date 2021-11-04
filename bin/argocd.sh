#!/bin/zsh

helm upgrade -i platform-cd \
charts/argocd-platform \
-n platform-system --create-namespace \
-f ./charts/argocd-platform/values/default.yaml \
-f ./charts/argocd-platform/values/$LIFECYCLE.yaml # --dry-run
