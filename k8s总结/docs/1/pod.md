P39

single-container pod
<img src="imgs/pod-single-pod.jpg" width=800 />
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

<img src="imgs/pod-multi.jpg" width=800 />

multi-container pod
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