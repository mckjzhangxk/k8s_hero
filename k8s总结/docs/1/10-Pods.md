# Pods



#### Kubernetes 中容器对于与应用，pod对应于虚拟机
  ![pod](../../images/pod.PNG)
  

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
  
## Docker Example (Docker Link)
  
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




