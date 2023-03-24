#Pod中 使用pvc


- 在这种情况下，Pods通过将声明用作卷来访问存储。Persistent Volume Claim必须存在于使用该声明的Pod的相同命名空间中。
- 集群在Pod的命名空间中找到声明并使用它来获取支持声明的Persistent Volume。然后将卷挂载到主机和Pod中。
- Persistent Volume是集群范围的，而Persistent Volume Claim是命名空间范围的。

#### 创建 Persistent Volume

```
pv-definition.yaml

kind: PersistentVolume
apiVersion: v1
metadata:
    name: pv-vol1
spec:
    accessModes: [ "ReadWriteOnce" ]
    capacity:
     storage: 1Gi
    hostPath:
     path: /tmp/data
```
```
$ kubectl create -f pv-definition.yaml

```

#### 创建 Persistent Volume Claim

```
pvc-definition.yaml

kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: myclaim
spec:
  accessModes: [ "ReadWriteOnce" ]
  resources:
   requests:
     storage: 1Gi
```
```
$ kubectl create -f pvc-definition.yaml
```

#### 创建  Pod

```
pod-definition.yaml

apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: web
  volumes:
    - name: web
      persistentVolumeClaim:
        claimName: myclaim
```
```
$ kubectl create -f pod-definition.yaml

```

