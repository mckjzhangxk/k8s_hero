https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/02-Core-Concepts/06-Kube-Controller-Manager.md


* controller有很多种，我们把它打成一个进程。

* controller是通过heatbeat来监控pod,node的，api-server是 controller与 kubelet的中继站。

* 常用的nodeController,replicaSetController,默认所有的controller都开启



安装部署这个服务 有2中方式

Haryway:
* 二进制文件
 ```
    $ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-controller-manager
 ```

* 配置文件: 
```
   cat /etc/systemd/system/kube-controller-manager.service
```
KubeAdam

* pod
```
   kubectl get pod -n kube-system kube-controller-manager-bjy-idc-brtc-laliu-test01
   // 数量和api-server一直，idc是三个
```
* 配置文件
```
    cat /etc/kubernetes/manifests/kube-controller-manager.yaml

    //启动命令的查看
    kubectl get pod -n kube-system kube-controller-manager-bjy-idc-brtc-laliu-test01 -o jsonpath='{.spec.containers[0].command}'|jq .

```