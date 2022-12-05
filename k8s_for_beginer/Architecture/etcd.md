https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/02-Core-Concepts/08-Kubelet.md


kubelet 不会自动被kubeadm自动安装，只能手动部署.

```
    $ wget https://github.com/etcd-io/etcd/releases/download/v3.3.11/etcd-v3.3.11-linux-amd64.tar.gz

    $ ./etcd #启动服务器

    $ ./etcdctl #启动客户端


    $ ./etcdctl set key1 value1
    $ ./etcdctl get key1

    //决定使用哪个版本
    export ETCDCTL_API=3
```

```
//获得服务器上的数据
etcdctl get / --prefix --keys-only --limit=10 
    --cacert /etc/kubernetes/pki/etcd/ca.crt 
    --cert /etc/kubernetes/pki/etcd/server.crt 
    --key /etc/kubernetes/pki/etcd/server.key"
```
## kubelet的作用
* Key-value存储，增加一个entry属性，无需影响全部
* v2,v3是主要的版本,export ETCDCTL_API=3
* 默认是2379端口
