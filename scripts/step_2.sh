#!/bin/bash

kubectl apply -f ../k8s/argo_config/
# kubectl wait --for=condition=Available --timeout=360s deploy/argocd-server -n argocd