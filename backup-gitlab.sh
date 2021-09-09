kubectl -n gitlab get secrets gitlab-rails-secret -o jsonpath="{.data['secrets\.yml']}" | base64 --decode > secrets.yaml

gitlab_task=gitlab-task-runner-57499c696c-8v6dh
kubectl -n gitlab exec $gitlab_task -it -- backup-utility