
参考文档：https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.19/#-strong-api-groups-strong-


教材：P130
### 0.什么是API Group?
  对应创建的k8s对象来说，第一行需要指定的apiVersion就是API Group,表明这个对象的创建路径
  ```
     格式： 
     core:   v1 
     named: /$ResourceGroup/v1/
  ```
### 1.api-server 许多group，与k8s对象相关的是的API group
- code组: /api,pod,namespace,configmap,pv,pvc,services
    ```
     对应的api路径 /api/v1/$resourceName
    ```
- named组:/apis: 下面分 ResourceGroup,新功能在这里添加
    ```
     对应的api路径： /apis/$ResourceGroup/v1/$resourceName

     eg:  /apis/apps/v1/Deployment
          /apis/storage.k8s.io/v1/StorageClass
          /apis/certificates.k8s.io/v1/CertificateSigingRequest
    ```
### 访问这些APi的方法
* 先建立本机代理
```
kubuctl proxy #开启代理，使用 admin.crt,admin.key,ca.crt 授权登录访问 api-server。
这样curl只需要访问本机代理，而不用考虑鉴权了
```

* 常用命令总结
```
kubectl api-resources 
```
```
curl http://127.0.0.1:8001/version  #集群版本

{
  "major": "1",
  "minor": "21",
  "gitVersion": "v1.21.0",
  "gitCommit": "cb303e613a121a29364f75cc67d3d580833a7479",
  "gitTreeState": "clean",
  "buildDate": "2021-04-08T16:25:06Z",
  "goVersion": "go1.16.1",
  "compiler": "gc",
  "platform": "linux/amd64"
}%
```

```
curl http://127.0.0.1:8001  -k #查看全部Group
```

```
curl http://127.0.0.1:8001/apis -k|grep "name"  查看/apis 下面的 ResourceGroup


      "name": "apiregistration.k8s.io",
      "name": "apps",
      "name": "events.k8s.io",
      "name": "authentication.k8s.io",
      "name": "authorization.k8s.io",
      "name": "autoscaling",
      "name": "batch",
      "name": "certificates.k8s.io",
      "name": "networking.k8s.io",
      "name": "extensions",
      "name": "policy",
      "name": "rbac.authorization.k8s.io",
      "name": "storage.k8s.io",
      "name": "admissionregistration.k8s.io",
      "name": "apiextensions.k8s.io",
      "name": "scheduling.k8s.io",
      "name": "coordination.k8s.io",
      "name": "node.k8s.io",
      "name": "discovery.k8s.io",
      "name": "flowcontrol.apiserver.k8s.io",
      "name": "crd.projectcalico.org",
      "name": "monitoring.coreos.com",
      "name": "snapshot.storage.k8s.io",
      "name": "application.kubesphere.io",
      "name": "argoproj.io",
      "name": "cluster.kubesphere.io",
      "name": "devops.kubesphere.io",
      "name": "gateway.kubesphere.io",
      "name": "gitops.kubesphere.io",
      "name": "installer.kubesphere.io",
      "name": "monitoring.kubesphere.io",
      "name": "network.kubesphere.io",
      "name": "storage.kubesphere.io",
      "name": "tenant.kubesphere.io",
      "name": "iam.kubesphere.io",
      "name": "quota.kubesphere.io",
      "name": "servicemesh.kubesphere.io",
      "name": "app.k8s.io",
      "name": "notification.kubesphere.io",
```

```
curl http://127.0.0.1:8001/api/v1/namespaces -k|grep name      #全部的namespace
curl http://127k0.0.1:8001/api/v1 -k|grep name |grep -v namespaced        #查看cores组（core group）下面的资源
curl http://127.0.0.1:8001/apis/apps/v1 -k|grep name|grep -v namespaced   #查看apis##apps组下面的资源
curl http://127.0.0.1:8001/apis/storage.k8s.io/v1 -k|grep name|grep -v namespaced   #查看apis##storage.k8s.io 组下面的资源
curl http://127.0.0.1:8001/apis/certificates.k8s.io/v1 -k|grep name|grep -v namespaced   #查看查看apis##certificates.k8s.io 组下面的资源
```