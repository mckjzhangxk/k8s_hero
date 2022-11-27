kubectl create deployment hello-world-service-single  --image=harbor.baijiayun.com/nginx/hello-app:1.0
kubectl scale deployment hello-world-service-single --replicas=2
kubectl expose deployment hello-world-service-single --port=80 --target-port=8080 --type=ClusterIP



kubectl create deployment hello-world-service-blue --image=harbor.baijiayun.com/nginx/hello-app:1.0
kubectl create deployment hello-world-service-red  --image=harbor.baijiayun.com/nginx/hello-app:1.0

kubectl expose deployment hello-world-service-blue --port=4343 --target-port=8080 --type=ClusterIP
kubectl expose deployment hello-world-service-red  --port=4242 --target-port=8080 --type=ClusterIP

