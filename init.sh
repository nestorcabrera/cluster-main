gcloud container clusters get-credentials gnappv2 --zone us-central1-a

#Add repos helm
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add jetstack https://charts.jetstack.io
helm repo add gitlab http://charts.gitlab.io/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

#----------------------Monitoring
helm install prometheus prometheus-community/kube-prometheus-stack \
    --namespace monitoring \
    --version 14.6.0 \
    --values values/prometheus.yaml \
    --create-namespace

helm upgrade --install grafana grafana/grafana \
    --namespace monitoring \
    --version 6.16.2 \
    --create-namespace


#-----------------------Ingress
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress \
    --version 4.0.1 \
    --values values/nginx.yaml \
    --create-namespace


#-----------------------Gitlab
#export PROJECT_ID=$(gcloud config get-value project)
#gcloud iam service-accounts create gitlab-gcs --display-name "Gitlab Cloud Storage"
#gcloud projects add-iam-policy-binlsding \
#    --role roles/storage.admin ${PROJECT_ID} \
#    --member=serviceAccount:gitlab-gcs@${PROJECT_ID}.iam.gserviceaccount.com
#gcloud iam service-accounts keys create --iam-account gitlab-gcs@${PROJECT_ID}.iam.gserviceaccount.com storage.config
#kubectl create secret generic storage-config --from-file=config=storage.config -n gitlab

kubectl create namespace gitlab
#-----------------------Secret credentials GCS
kubectl create secret generic storage-config --from-file=config=storage.config -n gitlab

helm upgrade --install gitlab gitlab/gitlab \
    --namespace gitlab \
    --timeout 600s \
    --version 5.2.1 \
    --set gitlab-runner.runners.privileged=true \
    --set nginx-ingress.enabled=false \
    --set global.ingress.enabled=false \
    --set global.ingress.configureCertmanager=false \
    --set certmanager.install=false \
    --set gitlab.task-runner.backups.objectStorage.backend=gcs \
    --set gitlab.task-runner.backups.objectStorage.config.gcpProject=dev-gasneiva-com \
    --set gitlab.task-runner.backups.objectStorage.config.secret=storage-config \
    --set gitlab.task-runner.backups.objectStorage.config.key=config \
    --values values/gitlab.yaml \
    --create-namespace

helm upgrade --install cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --version v1.5.3 \
    --set installCRDs=true \
    --create-namespace

kubectl apply -f ingress/tls-out/

kubectl -n gitlab get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo
kubectl get secret -n monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo