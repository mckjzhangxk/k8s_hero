https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/19-DNS-in-kubernetes.md


k8s默认会创建coreDNS

| Ip | HostName | Namespace | tyope | root
| - | - | - | - | - | 
| serverIp | mpc | beta |svc| cluster.local
| 10.10.10.10 | 10-10-10-10 | beta |pod| cluster.local



[CoreDNS](https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/20-CoreDNS-in-Kubernetes.md)

* K8s中的域名实现是中心化的
* Core DNS是一个 Deployment,replica=2
* kube-dns是为 coreDns创建的一个 ClusterIp Service，**pod 都会被自动配置 访问此service进行域名查询！**


* Core DNS 的配置是暴露出来的
```
    kubectl get configmap -n kube-system


Corefile:
---
.:53 {  //5端口
    errors
    health {       lameduck 5s
    }
    ready
    kubernetes cluster.local in-addr.arpa ip6.arpa {  //root=cluster.local
       pods insecure
       fallthrough in-addr.arpa ip6.arpa
       ttl 30
    }
    prometheus :9153
    forward . /etc/resolv.conf  #服务外的域名，从此处的域名解析地址
    cache 30
    loop
    reload
}
```

* 