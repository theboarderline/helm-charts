#!/bin/zsh

# helm template argocd-root \
# charts/argocd-root \
# -n argocd-system --create-namespace \
# --set lifecycle=$LIFECYCLE


helm template argocd-platform \
charts/argocd-platform \
-n platform-cd --create-namespace \
--set lifecycle=$LIFECYCLE
