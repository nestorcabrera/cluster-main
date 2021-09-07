helm upgrade --install gitlab-runner-gnapp gitlab/gitlab-runner \
    --namespace test \
    --timeout 600s \
    --version 0.32.0 \
    --values values/gitlab-runner-gnapp.yaml \
    --create-namespace