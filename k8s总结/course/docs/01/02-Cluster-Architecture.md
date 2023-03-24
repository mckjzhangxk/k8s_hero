- 创建 deployment [参考](../02-Core-Concepts/13-ReplicaSets.md),[参考](../15-Deployments.md)
- 创建service,[参考](../02-Core-Concepts/19-Services.md)
- 注入applo环境变量

以master为例
```yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  name: master-deployment
  namespace: test-center
  labels:
    app: master-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: master-pod
  template:
    metadata:
      name: master
      creationTimestamp: null
      labels:
        app: master-pod
    spec:
      containers:
        - name: master
          image: 'registry.cn-beijing.aliyuncs.com/bjy-webrtc/brtcmaster:v2023030701'
          env:
            - name: CONFIG_APOLLO_SECRET
              value: 9d01995713a448bf9ad1b9db56f35e64
            - name: CONFIG_APOLLO_URL
              value: 'http://apollo-dev.baijiayun.com:8080'
            - name: CONFIG_APOLLO_APPID
              value: K8sConfig
            - name: CONFIG_APOLLO_CLUSTER
              value: DEV
            - name: CONFIG_APOLLO_NAMESPACE
              value: master.yaml
            - name: CONFIG_APOLLO_BACKUP_PATH
              value: ./
```


```yaml
kind: Service
apiVersion: v1
metadata:
  name: master-service
  namespace: test-center
spec:
  ports:
    - protocol: TCP
      port: 8885
      targetPort: 8885
      nodePort: 31464
  selector:
    app: master-pod
  type: NodePort
```