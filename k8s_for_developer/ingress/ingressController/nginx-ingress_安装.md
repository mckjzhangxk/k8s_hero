<!-- kubectl create namespace ingress-space -->
<!-- kubectl create configmap  -n ingress-space nginx-configuration -->
<!-- kubectl create serviceaccount  -n ingress-space ingress-serviceaccount -->
# 手动一步一步安装

<h1 align="center">
  <a href="https://pion.ly"><img src="./recipe/controller-ingress.jpeg" ></a>
</h1>

[namespace](recipe/nginx-ingress-namespace.yaml)
[configmap](recipe/nginx-ingress-configmap.yaml)
[serviceAccount](recipe/nginx-ingress-serviceAccount.yaml)
[role](recipe/nginx-ingress-role.yaml)
[deployment](recipe/nginx-ingress-controller.yaml)
[service](recipe/nginx-ingress-service.yaml)

kubectl apply -f nginx-ingress-namespace.yaml
kubectl apply -f nginx-ingress-configmap.yaml
kubectl apply -f nginx-ingress-serviceAccount.yaml
kubectl apply -f nginx-ingress-role.yaml


kubectl apply -f nginx-ingress-controller.yaml
kubectl apply -f nginx-ingress-service.yaml


以上步骤可以帮助我们理解 ingress-controller需要那些k8s 组件。


# 生成环境安装步骤

##添加仓库
```
#添加仓库
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
```

### 方式1 ,离线安装
```
  helm pull   nginx-stable/nginx-ingress --version 0.7.1  //version是chart的版本
  helm install ./nginx-ingress
```

### 方式2 ,在线安装
```
  helm install nginx-release nginx-stable/nginx-ingress
```
### 覆盖传参数
```
--set controller.image.repository=harbor.baijiayun.com/nginx/nginx-ingress-controller:0.21.0
--set controller.service.type="NodePort"
```
