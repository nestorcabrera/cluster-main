helm upgrade --install gitlab-runner-gnapp gitlab/gitlab-runner \
    --namespace gitlab \
    --timeout 600s \
    --version 5.2.1 \
    --namespace gitlab \
    --values values/gitlab-runner-gnapp.yaml \
    --create-namespace