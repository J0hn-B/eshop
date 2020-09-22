# Kubernetes sample application with ArgoCD

The app: <https://microservices-demo.github.io/>  
Tested with Kind, an average of 16Gb of RAM required.

Architecture explained:  

- The application consists of 10 microservices. Each microservice is deployed with each own Helm chart.
- In a real world scenario, each microservice (code, Dockerfile, Helm Chart, etc..) lives in each own github repo.
- For simplicity in this demo, all application microservices charts are under the folder `services`

Folders:

1) **app:**  
    - **argo_config:**  ArgoCD manifests for the application and the project. From inside app/ folder:  
      `kubectl apply -f argo_config`
    - **eshop:**  **[Helm chart]**. This will install all the application's Helm charts. App of apps aproach, as described in ArgoCD documentation.

2) **k8s:**  
    - **argo_config:** ArgoCD manifests for the cluster management application and the project. From inside k8s/ folder:  
     `kubectl apply -f argo_config`
    - **k8s-charts:** Helm charts related only to the K8s cluster management (ex: Prometheus).  
        `cd k8s-charts` --> `helm pull prometheus-community/kube-prometheus-stack --untar` --> modify values.yaml
    - **k8s-configuration:**  **[Helm chart]**. This will install all the Helm charts inside k8s-charts folder. App of apps aproach, as described in ArgoCD documentation.

3) **scripts:**  
    - scripts for initial configuration (ex: install argocd)

4) **services:**  
    - Application Helm charts.

## How to:  Cluster Management

`git clone https://github.com/J0hn-B/eshop.git`

`kind create cluster`  <https://kind.sigs.k8s.io/>

`cd ~/eshop/scripts` --> `chmod +x install_argocd.sh` --> `./install_argocd.sh`

From a second terminal: `cd /eshop/k8s` --> `kubectl apply -f argo_config`

Check your ArgoCD web UI, click **sync** in the k8s-cluster-management application (you may need to refresh your browser)  
    **metrics-server** must be healthy-synced, **k8s-cluster-management** must be healthy-synced. Prometheus must be **healthy-OutOfSync**. Click **sync**  

Access Grafana:  
`kubectl get secret prometheus-grafana -n prometheus  -o jsonpath='{.data.admin-password }' | base64 --decode`  
`kubectl port-forward svc/prometheus-grafana  -n prometheus 3000:80`

In **k8s-configuration** chart, check the templates.  
metrics-server.yml and prometheus-stack.yml used to deploy the charts from k8s-charts folder.  

## How to:  Application Deployment

`cd ~/eshop/app` --> `kubectl apply -f argo_config`  
Check your ArgoCD web UI, click **sync** in the **app-eshop** application (you may need to refresh your browser)
