helm template ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress \
  --version 4.0.1 \
  --values values/nginx.yaml \
  --output-dir generador/ingress-nginx

helm template gitlab gitlab/gitlab \
    --namespace gitlab \
    --timeout 600s \
    --set gitlab-runner.runners.privileged=true \
    --set gitlab.task-runner.backups.objectStorage.backend=gcs \
    --set gitlab.task-runner.backups.objectStorage.config.gcpProject=dev-gasneiva-com \
    --set gitlab.task-runner.backups.objectStorage.config.secret=storage-config \
    --set gitlab.task-runner.backups.objectStorage.config.key=config \
    --version 5.2.1 \
    --namespace gitlab \
    --values values/gitlab.yaml \
    --output-dir generador/gitlab

helm template gitlab gitlab/gitlab \
    --namespace gitlab \
    --timeout 600s \
    --set gitlab-runner.runners.privileged=true \
    --set nginx-ingress.enabled=false \
    --set global.ingress.enabled=false \
    --set global.ingress.configureCertmanager=false \
    --set global.ingress.class=nginx \
    --set certmanager.install=false \
    --set global.appConfig.backups.bucket=gitlab-backup-storage \
    --set global.appConfig.backups.tmpBucket=gitlab-tmp-storage \
    --set gitlab.task-runner.backups.objectStorage.backend=gcs \
    --set gitlab.task-runner.backups.objectStorage.config.gcpProject=dev-gasneiva-com \
    --set gitlab.task-runner.backups.objectStorage.config.secret=storage-config \
    --set gitlab.task-runner.backups.objectStorage.config.key=config \
    --set global.registry.bucket=dev-resgistry \
    --set global.appConfig.artifacts.bucket=dev-gitlab-artifacts \
    --set global.appConfig.lfs.bucket=dev-git-lfs \
    --set global.appConfig.packages.bucket=dev-gitlab-packages \
    --set global.appConfig.uploads.bucket=dev-gitlab-uploads \
    --set global.appConfig.externalDiffs.bucket=dev-gitlab-mr-diffs \
    --set global.appConfig.terraformState.bucket=dev-gitlab-terraform-state \
    --version 5.2.1 \
    --values values/gitlab.yaml \
    --create-namespace\
    --output-dir generador/gitlab