kubectl create namespace ingress-space
kubectl create configmap  -n ingress-space nginx-configuration
kubectl create serviceaccount  -n ingress-space ingress-serviceaccount