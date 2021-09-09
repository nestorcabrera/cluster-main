gcloud container clusters create gnappv2 \
	--zone us-central1-a \
	--num-nodes 3 \
	--machine-type=n1-standard-2 \
    --no-enable-basic-auth \
    --cluster-version "1.20.8-gke.2100" \
    --release-channel "regular" \
    --image-type "COS_CONTAINERD" \
    --disk-type "pd-standard" --disk-size "100" 

gcloud container clusters get-credentials gnappv2 --zone us-central1-a

#-----------------------Gitlab
export PROJECT_ID=$(gcloud config get-value project)
gcloud iam service-accounts create gitlab-gcs --display-name "Gitlab Cloud Storage"
gcloud projects add-iam-policy-binlsding \
    --role roles/storage.admin ${PROJECT_ID} \
    --member=serviceAccount:gitlab-gcs@${PROJECT_ID}.iam.gserviceaccount.com
gcloud iam service-accounts keys create --iam-account gitlab-gcs@${PROJECT_ID}.iam.gserviceaccount.com storage.config
#kubectl create secret generic storage-config --from-file=config=storage.config -n gitlab