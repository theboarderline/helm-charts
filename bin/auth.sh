#!/bin/bash


source ./bin/check_env.sh

gcloud config set project $GKE_PROJECT

if [[ $1 == 'failover' ]]; then
  CLUSTER="$FAILOVER_CLUSTER"
  ZONE=$FAILOVER_ZONE
fi

echo
gcloud container clusters get-credentials --zone=$ZONE $CLUSTER
kubectl config set-context --current --namespace argocd
echo
