P64页  
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
### Server 端的证书：

* API-Server: apiserver.crt,apiserver.key
        管理员，Schedular,ControllerManager,都是api-server的客户端,通过api,管理或者监控或者操作K8s。

* Kubelet: kuelet.crt,kubulet.key 
        apiserver是Kubelet Server的客户端，请求 kuelet 部署pod,上报pod的监控信息等
```
        一下内容需确认：
        CN:system:node:$Nodename
        OU:system:nodes
```
* ETCD: etcd.crt,etcd.key
        apiserver是其客户端，etcd作为apiserver的数据库使用

### Client 端的证书

* kubectl,RestAPI,管理员： admin.crt,admin.key 
        apiserver 是服务器，这些客户端 需要 告诉 服务器自己是 合法用户（客户端证书是 被 CA 签过名的）

        openssl genrsa -out admin.key 2048
        openssl req -new -key admin.key -subj "/CN=kube-admin/OU=system:masters" -out admin.csr
        openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key  -CAcreateserial -out admin.crt
        //-CAcreateserial 字段创建序列号
        // OU=system:masters表示分组，属于管理员组

        //注意！ 这里CA 的cert,privateKey都需要，为啥？不是只用privateKe 签名吗？
        也可以把admin.key,admin.crt,ca.crt放到kube-config.yaml中！！！
* Schedular: sechdular.crt,sechdular.key 请求apiserver分配pod,部署服务

        openssl genrsa -out sechdular.key 2048
        openssl req -new -key sechdular.key -subj "/CN=SYSTEM:KUBE-SCHEDULAR" -out sechdular.csr
        openssl x509 -req -in sechdular.csr -CA ca.crt -CAkey ca.key  -CAcreateserial -out sechdular.crt
        //CN=SYSTEM:KUBE-SCHEDULAR

* ControllerManager: controller-manager.crt,controller-manager.key,请求api服务器给出 Pod的监控状态，维护pod的 status

        /CN=KUBE-CONTOLLER-MANAGER

* kube-proxy: kube-proxy.crt,kube-proxy.key 

* apiserver 请求etcd服务: apiserver-etcd.crt,apiserver-etcd.key

多对域名怎么办？？
* apiserver 请求kubulet服务： kubelet-client.crt,kubelet-client.key