要保证k8s安全，需要从下面2方面做出decision

* Authentication: who can access?  认证，用户系统
- 用户名，密码方式
* *  token方式
* *  LDAP
* *  security account
* *  Certificate

+ B.Authorization: what can do? 鉴权,权限的分配
+ +  RBAC: role based  access control
+ +  ABAC: attribute based access control


- C 认证过程中的工具：TLS Certificate：证明 加密公钥 没被篡改
```
    Api-Server,Etcd,Kube Controller Manager.kubelet,kube-proxy
直接的交互都是使用tls加密的.
```


