## Kubenetes证书文件的位置


* 部署的apiserver的配置文件：
/etc/systemd/system/kube-apiserver.service

* KubeAdm部署的apiserver的配置文件：
/etc/kubernetes/manifests/kube-apiserver.yaml

## 查看证书信息：

<font color="red">openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout </font>
- [ ] ssuer: 那个CA给我颁发的
- [ ] Validity:有效期
- [ ] Subject：Common Name,Group
- [ ] Subject Alternative Name:DNS 别名


## 检查日志：

kubectl logs etcd-bjy-idc-brtc-laliu-test01 -n kube-system

### 如何查看kebulet最为客户端的证书？
## 补充
https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/tools/kubernetes-certs-checker.xlsx