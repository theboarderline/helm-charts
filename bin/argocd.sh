#!/bin/zsh

helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argocd-install/
echo "charts/" > charts/argocd-install/.gitignore

helm upgrade -i argocd -n argocd --create-namespace charts/argocd-install

sleep 1000

helm upgrade -i root charts/argocd-root -n argocd


