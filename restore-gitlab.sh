gitlab_task=gitlab-task-runner-57499c696c-8v6dh
GS=gs://dev-gitlab-backup-storage/1631203153_2021_09_09_14.2.1_gitlab_backup.tar
kubectl exec $gitlab_task -it -- backup-utility --restore -t $GS