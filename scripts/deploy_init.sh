#!/bin/bash


# Deploy cluster management 
kubectl apply -f ../k8s/argo_config/ 
sleep 10
kubectl wait --for=condition=Ready --timeout=360s  pod --all -n prometheus

# Deploy application (eshop)
kubectl apply -f ../app/argo_config/
sleep 10
kubectl wait --for=condition=Ready --timeout=600s pod --all -n eshop