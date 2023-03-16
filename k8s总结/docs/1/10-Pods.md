# Pods



#### Kubernetes 中容器对于与应用，pod对应于虚拟机
  ![pod](../../images/pod.PNG)
  
- pod内的 container共享 pod的网络
- pod内的 container共享 pod的volume
- container应用down 会被 pod拉起
- pod 宕机 会被k8s拉起（replicaset）
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-foo
  labels:
    app: nginx-foo
spec:
  containers:
    - name: nginx
      image: nginx
```
![pod1](../../images/pod1.PNG)

#### Pod will have a one-to-one relationship with containers running your application.

  ![pod2](../../images/pod2.PNG)
  
## Multi-Container PODs

  
  ![pod3](../../images/pod3.PNG)
  

  
  ![pod4](../../images/pod4.PNG)
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-redis-foo
  labels:
    app:  nginx-redis-foo
spec:
  containers:
    - name: nginx
      image: nginx
    - name: redis
      image: redis
```


Deployment >> Replicaset >> Pod
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
  labels:
    app: redis-deployment
  namespace: training-common-test
spec:
  template:
    metadata:
      name: redis
      labels:
        app: redis-pod
    spec:
      containers:
        - name: redis
          image: redis
          ports:
            - containerPort: 6379
  replicas: 1
  selector:
    matchLabels:
      app: redis-pod
```




