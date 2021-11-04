#!/bin/zsh

helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argocd-install/
echo "charts/" > charts/argocd-install/.gitignore

helm install argocd -n argocd --create-namespace charts/argocd-install



