https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/11-CNI-in-Kubernetes.md


# Take away 

**Kubelet 创建pod的network namespace后,执行cni***

systemctl status kubelet.service

1.全部支持的cni
```
/opt/cni/bin
```
2..全部cni对应的配置
```
ls /etc/cni/net.d
```

Kubelet 启动的重要参数

--container-running-time: 使用的容器引擎
--container-runtime-endpoint:引擎的入口
--cni-bin-dir: 所有支持的cni二进制文件
--cni-conf-dir: 所有支持的cni二进制配置


kubelet用container-running-time 创建完成容器后，调用cni,来配置网络吗，那为什么kube-system的网络都是pod形式，这些pod的作用是什么？


### weave CNI 的工作原理
https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/12-CNI-weave.md


* Remember K8s的pod network就是要解决 podId 在哪个node上面的问题

* 以DeamonSet的形式部署在 node节点上，我们叫做agent

* Weave 会在 宿主机上部署 name=weave 的虚拟网络(bridge)。
* <font color=green>agent之前 互相通信，交换虚拟网络中pod的信息，最终每个agent都会知道 整个网络的toplogic</font>

* 当podA 向 podB 请求时，wave agent就会找到  podB的 ip,然后forward request


### IPAM: Ip地址的管理
* 地址分配plugin,local_host,dhcp，确保地址的唯一性
* weave 默认的ip空间是 10.32。0.0/12，也就是 10.32.0.1-10.47.255.254
* weave默认会把自己的地址空间 平分给nodes