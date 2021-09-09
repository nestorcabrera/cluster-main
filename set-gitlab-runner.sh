#helm upgrade --install gitlab-runner-gnapp gitlab/gitlab-runner \
#--namespace test \
#--set gitlabUrl=https://gitlab.gnappv2.dev.gasneiva.com/ \
#--set runnerRegistrationToken=SkpEh-svMmDCthSHQ3_6 \
#--set rbac.create=true \
#--set tags="kubernetes_gnapp" \
#--set privileged=true \
#--create-namespace
kubectl create namespace test
kubectl create secret generic google-application-credentials \
    --from-file=gcs-application-credentials-file=storage.config \
    --namespace test

helm upgrade --install --namespace test gitlab-runner-gnapp -f values/runner-chart-values.yaml gitlab/gitlab-runner \
    --create-namespace