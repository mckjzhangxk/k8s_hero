[Tutorial](https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/07-Security/21-Image-Security.md)


### 镜像域名组成：
{repositoryUrl}/{account}/{repositoryName}:tag

eg:
harbor.baijiayun.com/nginx/hello-app:1.0


### 如何保证镜像的私有化

```
1.创建一个docker-registry的secret

kubectl create secret docker-registry myusername \
  --docker-server=private-registry.io \ 
  --docker-username=registry-user \
  --docker-password=registry-password \
  --docker-email=registry-user@org.com

2.加入imagePullSecrets

apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: private-registry.io/apps/internal-app
  imagePullSecrets:
  - name: myusername
```



kubectl create secret docker-registry private-reg-cred \
  --docker-server=myprivateregistry.com:5000 \ 
  --docker-username=dock_user \
  --docker-password=docker_password \
  --docker-email=dock_user@myprivateregistry.com