
https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/02-Core-Concepts/05-Kube-API-Server.md


* k8s pod 中pod 节点是互通的,实现方式在集群部署**pod network**，pod network solution多种多样，idc使用的是calico。

* **kube-proxy是 与services对应的概念**
```
    service是k8s中的 pod服务代理的概念，每当我们创建一个service,
    node的kube-proxy收到api-server的通知后，会把
    serverName:serverPort与对应的podIp:targetPort记录在内存
    中的nats表

    podA-->serviceB-->podB1

    node上的proxy负责把 serviceB 转换成 podBi
    甚至每个proxy会创建监听端口，比如nodePoort!
```

* <font color=orange>不要把pod network与kube-proxy概念混淆，虽然都和网络有关，network-solution负责<font color=red>网络的创建(CNI plugin)</font>，而kube-proxy负责的是<font color=red>service的路由。</font></font>
* proxy是一个daemonset,每台机器都有一个 
    ```
        kubectl get daemonset -n kube-system
    ```

kubeproxy 安装部署这个服务 有2中方式

Haryway:
* 二进制文件
    ```
        $ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-proxy

        如何让二进制作为service运行？
    ```
    

KubeAdam

* pod
```
    kubectl get daemonset -n kube-system kube-proxy
```
* 配置文件
```

   kubectl get pod -n kube-system kube-proxy-4f9vk -o jsonpath='{.spec.containers[0].command}'|jq .
```