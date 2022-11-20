https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/02-Core-Concepts/08-Kubelet.md


kubelet 不会自动被kubeadm自动安装，只能手动部署.

```
    $ wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubelet

    $ ps -aux |grep kubelet 
```
## kubelet的作用
* 注册node节点
* 创建pod,container
* 检测，上报node,pod的状态
