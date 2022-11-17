kubectl create cronjob my-job --image=busybox --schedule="*/1 * * * *" -- date
kubectl create job my-job --image=busybox -- date