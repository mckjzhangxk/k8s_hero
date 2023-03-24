- 与主服务共享 日志目录 [参考](../08-Storage/06-Volumes.md)
- 多容器部署 [参考](../05-Application-Lifecycle-Management/12.Multi-Containers-PODs.md)
- 上报命名空间，podName



```yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  name: router-deployment
  namespace: test-center
  labels:
    app: router-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: router-pod
  template:
    spec:
      volumes:
        - name: filebeat-vol   #共享volume
          emptyDir: {}
      containers:
        - name: fealbeat
          image: 'harbor.baijiayun.com/elk/filebeat_7.5.0:latest'
          command:
            - sh
            - '-c'
            - filebeat --path.config /conf -e -E name=$namespace$hostname
          env:
            - name: hostname    #podname
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: metadata.name
            - name: namespace   #namespace
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: metadata.namespace
          volumeMounts:
            - name: filebeat-vol
              mountPath: /brtclogs
```