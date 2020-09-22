# Kubernetes sample application with ArgoCD

Architecture explained:  

- The application consists of 10 microservices. Each microservice is deployed with each own Helm chart.
- In a real world scenario, each microservice (code, Dockerfile, Helm Chart, etc..) lives in each own github repo.
- For simplicity in this demo, all application microservices charts are under the folder `services`

Folders:

1) **app:**  
    - **argo_config:**  ArgoCD manifests for the application and the project. From inside app/ folder:  
      `kubectl apply -f argocd_config`
    - **eshop:**  **[Helm chart]**. This will install all the application's Helm charts. App of apps aproach, as described in ArgoCD documentation.

2) **k8s:**  
    - **argo_config:** ArgoCD manifests for the cluster management application and the project. From inside k8s/ folder:  
     `kubectl apply -f argocd_config`
    - **k8s-charts:** Helm charts related only to the K8s cluster management (ex: Prometheus).  
        `cd k8s-charts` --> `helm pull prometheus-community/kube-prometheus-stack --untar` --> modify values.yaml
    - **k8s-configuration:**  **[Helm chart]**. This will install all the Helm charts inside k8s-charts folder. App of apps aproach, as described in ArgoCD documentation.

3) **scripts:**  
    - scripts for initial configuration (ex: install argocd)

4) **services:**  
    - Application Helm charts.
