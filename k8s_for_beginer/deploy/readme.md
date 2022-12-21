### hardway
[视频教程](https://www.youtube.com/watch?v=uUupRagM7m0&list=PL2We04F3Y_41jYdadX55fdJplDvgNGENo)
[图文教程](https://github.com/mmumshad/kubernetes-the-hard-way)



ETCD的Ha

```
启动参数：
      --name=bjy-idc-brtc-laliu-test01
      --advertise-client-urls=https://10.16.31.253:2379

      --client-cert-auth=true
      --cert-file=/etc/kubernetes/pki/etcd/server.crt
      --key-file=/etc/kubernetes/pki/etcd/server.key
      --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt

      --peer-client-cert-auth=true
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt


      --initial-advertise-peer-urls=https://10.16.31.253:2380
      --initial-cluster=bjy-idc-brtc-laliu-test01=https://10.16.31.253:2380
      --listen-client-urls=https://127.0.0.1:2379,https://10.16.31.253:2379
      --listen-metrics-urls=http://127.0.0.1:2381
      --listen-peer-urls=https://10.16.31.253:2380

      --snapshot-count=10000
      --data-dir=/var/lib/etcd

```

```
证书相关参数:
      //name: 此peer的name

      //cert-file：服务端的证书
      //key-file:服务端的key
      //trusted-ca-file:服务端的认证ca集群成员的通信端口

      //peer-cert-file：作为集群成员client使用的证书
      //peer-key-file:作为集群成员client使用的key
      //peer-trusted-ca-file:client认证ca

      //initial-cluster:指定所有的peer，包括自己

      //listen-client-urls: 客户端监听的地址
      //listen-peer-urls:  机器peer监听的地址
```

```
通信相关参数:
```

[Hardway 安装](https://www.youtube.com/watch?v=uUupRagM7m0&list=PL2We04F3Y_41jYdadX55fdJplDvgNGENo)
[kubeadm安装](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
[k8s组件版本](https://kubernetes.io/releases/version-skew-policy/#supported-versions)

[ububtu安装](https://github.com/justmeandopensource/kubernetes/blob/master/docs/install-cluster-ubuntu-20.md)

go 安装教程（https://zhuanlan.zhihu.com/p/453462046）
registry.aliyuncs.com/google_containers

kubeadm init --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --apiserver-advertise-address=192.168.56.2 --pod-network-cidr=10.177.0.0/16 --cri-socket=unix:///var/run/cri-dockerd.sock
