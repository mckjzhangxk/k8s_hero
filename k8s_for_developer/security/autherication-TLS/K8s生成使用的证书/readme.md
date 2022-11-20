P64页  
https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/07-Security/06-TLS-in-Kubernetes.md

https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/07-Security/07-TLS-in-Kubernetes-Certificate-Creation.md
## 需要生成那些证书?

### CA: ca.crt,ca.key
    CA是证明所有其他证书 合法的【机构】,合法性是指 证书【声明的组织】与【提供的 公钥】的对应性。

    ca.key 用于签名
    ca.crt 用于其他 服务验证签名

    openssl genrsa -out ca.key 2048  
        //生成私钥
    openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
        //生成证书请求
        //-new 表示新的请求
        //-key  私钥
        //-subj 签名的内容主体，/CN=CommonName
    openssl x509 -req -in  ca.csr -signkey ca.key -out ca.crt 
        //自签名证书 -req 表示输入是csr,
        //-in 输入
        //-signkey 使用自签名证书
        //-out 输出
注意：在k8s中可以由多个CA，一个用户etcd客户端，服务站之前的证书认证(etcd.crt,apt-server_etcd.crt)，另外一个用于其他k8s的组件间的认证（eg:schdular.crt,apiserver.crt）
### Server 端的证书：

* **API-Server**: apiserver.crt,apiserver.key
        管理员，Schedular,ControllerManager,kubelet,kubeproxy都是api-server的客户端,通过api,管理或者监控或者操作K8s。

        注意：apiserver要生成3个cert,服务器的，对ectd的，对all  kubelet的，这三个可以指向一个文件证书，在api-server启动的时候配置.
[生成证书](api-server/cmd.sh) 
* **Kubelet**: kuelet.crt,kubulet.key,kuele-client.crt,kuele-client.key
        apiserver是Kubelet Server的客户端，请求 kuelet 部署pod
        kubelet也是apiserver,上报pod信息，这样，我们需要**标识每个kubelet 的身份**
```
        一下内容需确认：
        CN:system:node:$Nodename
        O:system:nodes
```
[生成证书](kubelet/cmd.sh) 
* ETCD: etcd.crt,etcd.key
        apiserver是其客户端，etcd作为apiserver的数据库使用

        证书的生成： 注意ETC是集群的，需要为每个peer都生成etcd-peer.crt,etcd-peer.key.
```
        openssl genrsa -out etcd.key 2048
        openssl req -new -key etcd.key -subj "/CN=etcd" -out etcd.csr
        openssl x509 -req -in etcd.csr -CA ca.crt -CAkey ca.key  -CAcreateserial -out etcd.crt
```
[生成证书](ETCD/readme.md)

### Client 端的证书

* **kubectl,RestAPI,管理员： admin.crt,admin.key** 
        apiserver 是服务器，这些客户端 需要 告诉 服务器自己是 合法用户（客户端证书是 被 CA 签过名的）

        openssl genrsa -out admin.key 2048
        openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr
        openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key  -CAcreateserial -out admin.crt
        //-CAcreateserial 字段创建序列号
        // OU=system:masters表示分组，属于管理员组



**注意1**: 我们要创建管理员而不是不同用户，光有用户名CN=kube-admin无法分辨这是管理员,<font color=blue>需要添加用户组进行说明这是管理员(/O=system:masters)</font>,否则需要创建Role,RoleBinding..
**注意2**：把生成的admin.key,admin.crt,ca.crt放到kube-config.yaml中,或者用于RESTAPI,见[使用管理员证书](kubectlAdmin/readme.md)
问题1  这里CA 的cert,privateKey都需要，为啥？不是只用privateKe 签名吗？

* Schedular: sechdular.crt,sechdular.key 请求apiserver分配pod,部署服务

        openssl genrsa -out sechdular.key 2048
        openssl req -new -key sechdular.key -subj "/CN=SYSTEM:KUBE-SCHEDULAR" -out sechdular.csr
        openssl x509 -req -in sechdular.csr -CA ca.crt -CAkey ca.key  -CAcreateserial -out sechdular.crt
        //CN=SYSTEM:KUBE-SCHEDULAR

注意:schedular是k8s 系统级别的组件，对应的sa需要有相应的权限，<font color=blue>名字前加入SYSTEM前缀</font>才可以获得相应权限**
* ControllerManager: controller-manager.crt,controller-manager.key,请求api服务器给出 Pod的监控状态，维护pod的 status

        /CN=SYSTEM:KUBE-CONTOLLER-MANAGER
注意:ControllerManager是k8s 系统级别的组件，对应的sa需要有相应的权限，<font color=blue>名字前加入SYSTEM前缀</font>才可以获得相应权限**
* kube-proxy: kube-proxy.crt,kube-proxy.key 

        kube-proxy是在node上对service 的域名映射的，需要访问api-server,获得service对应的pod地址？？

* apiserver 请求etcd服务: apiserver-etcd.crt,apiserver-etcd.key

多对域名怎么办？？
* apiserver 请求kubulet服务： kubelet-client.crt,kubelet-client.key