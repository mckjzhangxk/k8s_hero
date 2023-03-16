# Persistent Volumes


In this section, we will take a look at **Persistent Volumes**

- In the large evnironment, with a lot of users deploying a lot of pods, the users would have to configure storage every time for each Pod.
- Whatever storage solution is used, the users who deploys the pods would have to configure that on all pod definition files in his environment. Every time a change is to be made, the user would have to make them on all of his pods.

![class-16](../../images/class16.PNG)




-  cluster-wide pool 
-  users can now select storage from this pool using Persistent Volume Claims.



  ```
  $ kubectl get pv|grep mongo-volume
  $ kubectl get pvc -n test-center|grep "mongo-volume-"
  ```


![class-14](../../images/class14.PNG)



## host Volume映射

- 时区同步: /etc/localtime 
- 自动化打包:/var/run/docker.sock
- node-shell:/
![class-15](../../images/class15.PNG)

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-record
  namespace: bmcu
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
```

mcu.yaml
```yaml
      volumes:
        - name: pvc-record-vol
          persistentVolumeClaim:
            claimName: pvc-record
      containers:
        - name: worker
          image: 'registry.cn-beijing.aliyuncs.com/webrtc-mcu/mcu:20230207'
          env:
            - name: POD_IP
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: status.podIP
          resources: {}
          volumeMounts:
            - name: pvc-record-vol
              mountPath: /record
```
cloudrecordproc.yaml
```yaml
      volumes:
        - name: pv-record-vol
          persistentVolumeClaim:
            claimName: pvc-record
      containers:
        - name: cloudproc
          image: 'registry.cn-beijing.aliyuncs.com/webrtc-mcu/cloudrecordproc:20230207'
          volumeMounts:
            - name: config-vol
              mountPath: /app/cloudrecordproc/config
            - name: pv-record-vol
              mountPath: /nas/record
```