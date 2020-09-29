#!/bin/bash


CYAN='\033[1;36m'
GREEN='\033[0;32m'
LBLUE='\033[1;34m'
NC='\033[0m'

# Deploy cluster management 
kubectl apply -f ../k8s/argo_config/ 
echo -e "${LBLUE}Getting the cluster ready :)${NC}\n"
sleep 40;
echo -e "${LBLUE}Checking Prometheus.... :))${NC}\n"
kubectl wait --for=condition=Available --timeout=300s deploy prometheus-kube-prometheus-operator -n prometheus
kubectl wait --for=condition=Available --timeout=300s deploy prometheus-kube-state-metrics -n prometheus
kubectl wait --for=condition=Available --timeout=300s deploy prometheus-grafana -n prometheus


# Deploy application (eshop)
echo -e "${LBLUE}Getting your application ready ;))${NC}\n"
kubectl apply -f ../app/argo_config/
sleep 50;

echo -e "${LBLUE}Checking app deployments.... :)${NC}\n"
kubectl wait --for=condition=Available --timeout=600s deploy front-end  -n eshop
kubectl wait --for=condition=Available --timeout=600s deploy catalogue  -n eshop
echo -e "${LBLUE}Application is getting ready, check ArgoCD UI or Dashboard for progress ;))${NC}\n"

# Create custom resources for Chaos-Mesh
curl -sSL https://mirrors.chaos-mesh.org/v1.0.0/crd.yaml | kubectl apply -f -