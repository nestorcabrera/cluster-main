helm upgrade --install gitlab-runner-gnapp gitlab/gitlab-runner \
    --namespace gitlab \
    --timeout 600s \
    --version 0.32.0 \
    --namespace gitlab \
    --values values/gitlab-runner-gnapp.yaml \
    --create-namespace