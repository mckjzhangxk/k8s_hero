https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/02-Core-Concepts/07-Kube-Scheduler.md

sehedular的作用

* 计算给出Pod放到node的合理方案，合理利用集群资源。

* pod,node的信息都来自api-server

* 下达分配任务命令的是api-server,执行命令的是kubelet，schedular就是个参谋。

* 和scheduler 有关的主题

 * *  node label,pod node selector,affinity
 * * taint_tolerant_affinity_node_selector
  * *  resource_limit

安装部署这个服务 有2中方式

Haryway:
* 二进制文件
    ```
    $  wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-scheduler
    ```
    
* 配置文件: 
```
    cat /etc/systemd/system/kube-apiserver.service 
```
KubeAdam

* pod
```
    kubectl get pod -n kube-system |grep kube-schedular
    #idc就有三个schedular
```
* 配置文件
```
    cat /etc/kubernetes/manifests/kube-scheduler.yaml

    //启动命令的查看
    kubectl get pod -n kube-system kube-scheduler-bjy-idc-brtc-laliu-test01 -o jsonpath='{.spec.containers[0].command}'|jq .
    
```