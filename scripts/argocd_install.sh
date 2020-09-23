#!/bin/bash


CYAN='\033[1;36m'
GREEN='\033[0;32m'
LBLUE='\033[1;34m'
NC='\033[0m'
# Create namespace, install ArgoCD and port-forward. Run the script from your laptop.
kubectl create namespace argocd;
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml;

echo -e "${LBLUE}Waiting for ArgoCD installation ...... :)${NC}\n"
kubectl wait --for=condition=Available --timeout=360s deploy/argocd-server -n argocd
echo -e "${GREEN}ArgoCD is ready! Enjoy ;))${NC}\n"

PASS=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2)

echo -e "${CYAN}--> This is your username:${NC}${GREEN} admin${NC}\n"
echo -e "${CYAN}--> This is your password:${NC}${GREEN} ${PASS}${NC}\n"


echo -e "${LBLUE}--> Access argocd web ui in:${NC}${GREEN} localhost:8080${NC}\n"
kubectl port-forward svc/argocd-server -n argocd 8080:443
