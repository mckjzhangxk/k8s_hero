
教材：P145

为什么需要 Authorization：
- [] 为不同的应用创建 user account
- [] 对account的操作 做权限限制

Authorization Mechanusms

* Node: 除了kubectl（admin)访问api-server,kubelet也可以访问apiserver,决定 kubelet访问权限的是node Authorizaer.
```
Kubelet需要
read
    nodes,pods,services,endpoints
write:
    node status,pod status,event

Kubelet”用户“证书的必须按照如下：
    CN:system:node:$Nodename
    OU:system:nodes
```
* ABAC:  针对admisistrator,developr,为每个用户或者用数组 设置它的权限
* RBAC： 针对admisistrator,developr,为每个Role设置它的权限,然后用户和Role进行绑定.
* Webhook: 权限有第三方决定
* AlwayAllow: 永远允许
* AlwayDeny: 永远不允许


如何设置authorization
* apiserver的启动参数：/etc/kubernetes/manifests/kube-apiserver.yaml 中--authorization-mode 参数指定

* 如果指定多个模式，模式按照指定顺序进行授权操作
```
    --authorization-mode=node,RBAC,Webhook
    user-->node-->RBAC-->Webhook
       拒绝Deny    赞成Approve
```

user-->node-->RBAC-->Webhook
       拒绝Deny    赞成Approve