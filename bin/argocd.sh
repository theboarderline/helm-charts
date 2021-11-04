#!/bin/zsh

helm upgrade -i argocd-root \
charts/argocd-root \
-n argocd-system --create-namespace \
--set lifecycle=$LIFECYCLE
