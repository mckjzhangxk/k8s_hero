https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/17-Service-Networking.md


## service 网络的原理

* service是虚拟概念，namespace与之相关！
* service 有IP，这个IP是在 创建service的时候，api-server分配的。
* 每台机器上运行 的**kubeproxy负责建立 serviceIp与 backend pod Ip的对应关系**。使用iptables.

| serverIp   | podIp |
|    -        |    -   |
|  mpc-service        |   mpc-node    |
|  msg-service        |   msg-pod    |

* nodeport 会在node上创建并listen对应的nodePort


## 配置：

API server指定 serviceIp的range

```
$ ps -aux | grep kube-apiserver
apiServer --service-cluster-ip-range=10.96.0.0/12 
//从10.96.0.0开始，到10.96.0.0+2^12


查看service规则日志
$ cat /var/log/kube-proxy.log


iptables -L -t nat | grep local-cluster
//查看 service到pod的路由
-L

```

## KubeProxy:

* kubeproxy 是daemonset部署
* <font color="red">非静态pod</font>
* kubuctl logs 可以查看 地址转换工具,默认Iptables