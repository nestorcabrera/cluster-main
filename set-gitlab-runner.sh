#helm upgrade --install gitlab-runner-gnapp gitlab/gitlab-runner \
#--namespace test \
#--set gitlabUrl=https://gitlab.gnappv2.dev.gasneiva.com/ \
#--set runnerRegistrationToken=SkpEh-svMmDCthSHQ3_6 \
#--set rbac.create=true \
#--set tags="kubernetes_gnapp" \
#--set privileged=true \
#--create-namespace

helm upgrade --install --namespace test gitlab-runner-gnapp -f values/runner-chart-values.yaml gitlab/gitlab-runner