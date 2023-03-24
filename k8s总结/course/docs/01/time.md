*  映射主机的localtime 文件[参考](../08-Storage/06-Volumes.md)


```yaml
spec:
  replicas: 1
  selector:
    matchLabels:
      app: router-pod
  template:
    metadata:
      name: router
      creationTimestamp: null
      labels:
        app: router-pod
    spec:
      volumes:
        - name: host-time
          hostPath:
            path: /etc/localtime
            type: ''
      containers:
        - name: router
          image: 'registry.cn-beijing.aliyuncs.com/bjy-webrtc/rtcs:v2023022002'
          volumeMounts:
            - name: host-time
              readOnly: true
              mountPath: /etc/localtime
```