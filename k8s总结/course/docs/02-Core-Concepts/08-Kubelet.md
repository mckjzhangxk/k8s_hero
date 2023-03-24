# Kubelet

  


#### Kubelet worker节点和  Kubernetes 集群的唯一联系点。
- Kubelet 会在节点上创建 Pod，而Schedular仅决定 Pod 应该放在哪里。.

  ![kubelet](../../images/kubelet.PNG)

## View kubelet options
- 您还可以通过在工作节点上列出进程并搜索 kubelet，查看正在运行的进程和影响选项。
  ``` 
  $ ps -aux |grep kubelet
  ```
  
  ![kubelet2](../../images/kubelet2.PNG)
