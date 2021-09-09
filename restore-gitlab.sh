kubectl -n gitlab delete secret gitlab-rails-secret
kubectl -n gitlab create secret generic <rails-secret-name> --from-file=secrets.yml=secrets.yml

kubectl delete pods -lapp=sidekiq,release=gitlab
kubectl delete pods -lapp=webservice,release=gitlab
kubectl delete pods -lapp=task-runner,release=gitlab

gitlab_task=gitlab-task-runner-57499c696c-8v6dh
GS=gs:1631203153_2021_09_09_14.2.1
kubectl -n gitlab exec $gitlab_task -it -- backup-utility --restore -t $GS