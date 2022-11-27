### CA 服务器是什么：
   可以用CA key给用户csr签名的服务器都叫做ca服务器，也就是**ca.key所在的哪台机器**，<font color=red>k8s的control plane是典型的 ca 服务器</font>

### 给新的用户授权怎么做？

* 获得新用户的 certificate sign request

* 然后登陆服务器，用ca.key给这个csr签名，把签好的文件发给这个用户


* 或者
- [ ] 获得csr文件后，创建certificate sign object，交给k8s
- [ ] base64编码csr文件，放入request字段
```
   cat zxk.csr|base64|tr -d "\n"
```
- [ ] kubectl create -f zxk.yaml
- [ ] 创建的csr对象 会被管理员看到，通过或者拒绝认证请求：
```
   kubectl certificate approve/deny akshay
```
- [ ]  查看生成的证书：
```
kubectl get csr zxk -o yaml
echo "xxxx" |base64 --decode

```
### k8s中那个组件负责csr对象的

controller manager负责监控用户创建的csr，并且签名，拒绝等。。。


```
$ kubectl get pod -n kube-system kube-controller-manager-bjy-idc-brtc-laliu-test01 -o jsonpath="{.spec.containers[0].command}"|jq

结果：

spec:
  containers:
  - command:
    - kube-controller-manager
    - --allocate-node-cidrs=true
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --bind-address=127.0.0.1
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --cluster-cidr=192.168.0.0/16
    - --cluster-name=kubernetes
    
    #用于签名的文件
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
    
    - --controllers=*,bootstrapsigner,tokencleaner
    - --kubeconfig=/etc/kubernetes/controller-manager.conf
    - --leader-elect=true
    - --port=0
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --root-ca-file=/etc/kubernetes/pki/ca.crt
    - --service-account-private-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --use-service-account-credentials=true
```

### 常用命令

* kubectl get csr   agent-smith -o yaml
* kubectl delete csr   agent-smith
* kubectl certificate approve agent-smith
* kubectl certificate deny agent-smith