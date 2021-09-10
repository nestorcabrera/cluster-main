kubectl -n gitlab delete secret gitlab-rails-secret
kubectl -n gitlab create secret generic gitlab-rails-secret --from-file=secrets.yml=backups/secrets-gitlab.yaml

kubectl -n gitlab delete pods -lapp=sidekiq,release=gitlab
kubectl -n gitlab delete pods -lapp=webservice,release=gitlab
kubectl -n gitlab delete pods -lapp=task-runner,release=gitlab