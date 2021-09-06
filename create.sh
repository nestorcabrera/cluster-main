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