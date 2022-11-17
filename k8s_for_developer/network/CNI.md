### CNI 是什么？

    CNI定义了，如何给【命名空间】定义网络，定义网络包括 创建Cable Link,创建 switch,设置route

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