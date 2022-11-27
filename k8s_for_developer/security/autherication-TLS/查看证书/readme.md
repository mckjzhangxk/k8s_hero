## Kubenetes证书文件的位置


* 部署的apiserver的配置文件：
/etc/systemd/system/kube-apiserver.service

* KubeAdm部署的apiserver的配置文件：
/etc/kubernetes/manifests/kube-apiserver.yaml
/etc/kubernetes/pki

## 查看证书信息：

<font color="red">openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout </font>
- [ ] ssuer: 那个CA给我颁发的
- [ ] Validity:有效期
- [ ] Subject：Common Name,Group
- [ ] Subject Alternative Name:DNS 别名


## 检查日志：

kubectl logs etcd-bjy-idc-brtc-laliu-test01 -n kube-system


## 证书一栏
[CA证书](../K8s%E7%94%9F%E6%88%90%E4%BD%BF%E7%94%A8%E7%9A%84%E8%AF%81%E4%B9%A6/idc-pki/ca.crt)

[apiserver-etcd客户端](../K8s%E7%94%9F%E6%88%90%E4%BD%BF%E7%94%A8%E7%9A%84%E8%AF%81%E4%B9%A6/idc-pki/apiserver-etcd-client.crt)
[apiserver-kubelet客户端](../K8s%E7%94%9F%E6%88%90%E4%BD%BF%E7%94%A8%E7%9A%84%E8%AF%81%E4%B9%A6/idc-pki/apiserver-kubelet-client.crt)
[apiserver服务端](../K8s%E7%94%9F%E6%88%90%E4%BD%BF%E7%94%A8%E7%9A%84%E8%AF%81%E4%B9%A6/idc-pki/apiserver.crt)


[kebelet客户端](../../kubeConfig/idc-kubeconfig/certs/kubelet-client-2022-10-17-18-55-30.pem/)
[kebelet服务端](../../kubeConfig/idc-kubeconfig/certs/kubelet.crt)

[schedular客户端](../../kubeConfig/idc-kubeconfig/scheduler.cert.cert)
[controllerManager客户端](../../kubeConfig/idc-kubeconfig/controller-manager.cert)


[kubeProxy](http://10.16.31.253:30880/clusters/default/projects/kube-system/configmaps/kube-proxy/detail): **通过configmap加载kubeconfig,使用的是kubeproxy的sa服务账号，token方式**
```
kubectl describe sa -n kube-system kube-proxy
```

<font color="green"> 问题：credential 与jwt  token如何进行转换？？</font>
## 补充(以下是hardway部署的一个信息）
https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/tools/kubernetes-certs-checker.xlsx


