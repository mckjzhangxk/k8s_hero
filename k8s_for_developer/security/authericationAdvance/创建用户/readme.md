### 给新的用户授权怎么做？

* 获得新用户的 certificate sign request

* 然后登陆服务器，用ca.cert给这个csr签名，把签好的文件发给这个用户


* 或者
- [ ] 获得csr文件后，创建certificate sign object
- [ ] base64编码csr文件，放入request字段
```
   cat zxk.csr|base64|tr -d "\n"
```
- [ ] kubectl create -f zxk.yaml
- [ ] 通过或者拒绝认证请求：
```
   kubectl certificate approve/deny akshay
```
- [ ]  查看生成的证书：
```
kubectl get csr zxk -o yaml
echo "xxxx" |base64 --decode
```
### 常用命令

* kubectl get csr   agent-smith -o yaml
* kubectl delete csr   agent-smith
* kubectl certificate approve agent-smith
* kubectl certificate deny agent-smith