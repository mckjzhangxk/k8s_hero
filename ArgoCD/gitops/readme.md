* what's gitops?
  gitops 是安装在 主机的一个服务， 监控git 上关于code的改变，让 k8s的Actual status 与 code 的Expected status 保持一致，【代码驱动部署】,git repository 也是唯一的（source of trusts）。
* Devops Vs GitOps
  两者的区别在于：Devops是把change 推送到k8s集群
  而GitOps 是k8s 监控，把 change pull下来的！
