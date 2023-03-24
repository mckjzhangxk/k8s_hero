* 自动注入ip
* 读取label,判断是否是固定msms
* rtp流量
* msms独占物理机



###自动注入ip

- 初始化容器，获得公网ip
- 公网ip 写入到 /root/externalIp文件，结束初始化执行,[参考](../08-Storage/06-Volumes.md)
```
      initContainers:
        - name: pubip
          image: 'harbor.baijiayun.com/sidecar/pubip:0.0.7'
          env:
            - name: Chioce
              value: '1'
            - name: NodeName
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: spec.nodeName
          resources: {}
          volumeMounts:
            - name: ip-volume
              mountPath: /root/externalIp
```
- msms启动区域 初始化容器输出的公网ip, 导出环境变量,[命令行](../05-Application-Lifecycle-Management/05-Commands-and-Arguments-in-Kubernetes.md),[环境变量](../05-Application-Lifecycle-Management/05-Commands-and-Arguments-in-Kubernetes.md)
- 启动msms


### 读取label,判断是否是固定msms
- 逻辑同获得公网ip,初始化容器读label -->注入msms容器
- 读取node的label需要特殊权限，，需要指定 serviceAccount，给serviceAccount绑定Role
```yaml
spec:
    serviceAccountName: msms-sa
    serviceAccount: msms-sa
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: msms-role-{{ .name }}
rules:
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - '*'
- nonResourceURLs:
  - '*'
  verbs:
  - '*'
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: msms-sa
  namespace: '{{ $.Release.Name}}-{{ .name }}'
---
# role binding
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: msms-role-binding-{{ .name }}
subjects:
 - kind: ServiceAccount
   name: msms-sa
   namespace: '{{ $.Release.Name}}-{{ .name }}'
roleRef:
   kind: ClusterRole
   name: msms-role-{{ .name }}
   apiGroup: rbac.authorization.k8s.io

```

### RTP 流量
- 配置hostnet,pod网络和node网络共用 ,[网络](../09-Networking/10-Pod-Networking.md)
```yaml
spec:
    hostNetwork: true
    dnsPolicy: ClusterFirstWithHostNet
```
### msms独占物理机
- 跨命名空间的 Pod反亲和规则配置  [亲和性](../03-Scheduling/09-Node-Affinity.md)
- 配置容错性，以防止在部署时其他服务抢占已经被指定为msms的机器。 [污点，容忍度](../03-Scheduling/11.Taints-and-Tolerations-vs-Node-Affinity.md)

```yaml
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: app
                    operator: In
                    values:
                      - msms-pod
                      - mpc-pod
                      - puller-pod
                      - redis-pod
                      - sentinel-pod
                      - master-pod
                      - messaging-pod
                      - mongo
                      - router-pod
                      - intelroute-pod
                      - shrink
                      - sniffer-pod
              topologyKey: kubernetes.io/hostname
              namespaces: ['test-center','test-bj','test-sh']
```
```yaml
      tolerations:
      - key: "app"
        operator: "Equal"
        value: "msms"
        effect: "NoExecute"
```
