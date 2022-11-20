https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/02-Core-Concepts/05-Kube-API-Server.md


apiserver 在处理请求时候的三大步骤

1.authenticae 用户合法吗？
2.验证用户有没有调用api的权限？
3.CRUD ETCD的数据


安装部署这个服务 有2中方式

Haryway:
* 二进制文件
    ```
    $ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-apiserver
    ```
    
* 配置文件: 
```
    cat /etc/systemd/system/kube-apiserver.service 
```
KubeAdam

* pod
```
    kubectl get pod -n kube-system |grep kube-apiserver
    #idc就有三个apisevver
```
* 配置文件
```
    cat /etc/kubernetes/manifests/kube-apiserver.yaml

    //启动命令的查看
    kubectl get pod -n kube-system kube-apiserver-bjy-idc-brtc-laliu-test0202 -o jsonpath='{.spec.containers[0].command}'|jq .
    
```