https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/07-Pre-requisite-CNI.md
### CNI 是什么？

    CNI定义了，如何给【命名空间】定义网络，定义网络包括 
```
    创建Cable Link，Switch
    把【虚拟设备】与 Switch连接好
    为【虚拟设备】分配IP地址
    启动【虚拟设备】
    设置route
```
### CNI 的组成

* CNI的 runtime:
    * * 有 docker,rocket,kubenetes...
    * * 1创建network namespace
    * * 2.弄清容器和network namespace的关系的关系
    * * 3.与plugin交互，add,delete
    * * 4.规范化 交互格式为json

* CNI 的plugin
    * * 创建 完整虚拟网络的”程序“,或者说配置网络传程序。
    * * 支持add,del命令规范
    * * 支持的参数规范
    * * 管理pod 与分配的IP地址的关系
### k8s的网络plugin支持那些？

    1.可以查看/opt/cni/bin/下是所有支持的plugin
    2./etc/cni/net.d是目前使用的网络plugin,
    3.网络plugin定义为daomonSet下维护的 pod


### k8s 为什么没有实现网络？
    k8s只负责创建pod的namespace,不去给容器分配网络地址。
    但k8s对网络的实现 有一下要求
    1）pod IP 唯一
    2）同一node下 pod可以互通
    3）不通node下 的 pod也可以互通
    4) 以上都不需要配置 NATS就可以实现
[pod network](https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/10-Pod-Networking.md)

### 模拟pod network的实现 [pod network](https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/10-Pod-Networking.md)
假设我有3node,LAN是互通的
| node1 | node2 |  node3 |
| - | - | - |

- [ ] 第一步 node1-3上创建虚拟网络，分配虚拟网络地址

|节点| node1 | node2 |  node3 |
| - | - | - | - |
| switchName | bridge  | bridge  | bridge
| 虚拟网段| 172.0.1.0|172.0.2.0|172.0.3.0
| 虚拟网关地址| 172.0.1.1|172.0.2.1|172.0.3.1

- [ ] 为新创建的pod，创建一对virtual cable和namespace,cable的一端加入namespace,一端连上对应机器的 bridge，pod在自己ns中 <font color=blue>配置路由表，默认的gateway是 bridge</font>

以上步骤完成后：
* <font color=blue>由于node上的虚拟网段不重叠，pod有了唯一的ip.</font>
* 虚拟网关 可以访问 Lan 上的node，宿主机 可以访问 本机的 namespace newtork
```
  pod --> Lan node // pod 设置了 default via bridge
  host --> pod    // bridge 分配的ip,bridge和 pod在相同的网络。 
```

- [ ] 第二步 配置自己的nats路由表


节点| node1 | node2 |  node3 |
| - | - | - | - |
| switchName | bridge(v1)  | bridge(v2)  | bridge(v2)
| 虚拟网段| 172.0.1.0|172.0.2.0|172.0.3.0
| 虚拟网关地址| 172.0.1.1|172.0.2.1|172.0.3.1
|路由规则设置| v2 via node2 <br>v3 via node3| v1 via node1 <br>v3 via node3| v2 via node2 <br>v1 via node1

* <font color=blue>以上步骤保证了pod直接的互通.</font>

### 创建pod去过程
CNI Plugin:netscript.sh
```
1)ADD namespace
 create pair veth
 attach pair veth
 assign ip addr
 ip -n <namespace> set ...

2)DEL
  del link ...
```

* kubelet创建network namespace,
* kubelet使用cni作为 ”网络的解决方案“,ADD,DEL
