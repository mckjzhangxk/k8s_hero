###  pulling timeout
P39：每隔设置的时间，argocd执行一次Pull操作，对吧git与 k8s的区别。

```sh
kubectl describe pod -n argocd argocd-repo-server-7d4dbbc6d7-spdj6 |grep "RECON"

#修改reconciliation=15s
kubectl -n argocd patch configmap argocd-cm --patch='{"data":{"timeout.reconciliation":"15s"}}'
#再次检查配置
kubectl get configmap -n argocd argocd-cm
#重启服务
kubectl -n argocd rollout restart deploy argocd-repo-server
```

### webhook
- 由于没有证书，修改argocd-server启动配置，或者关闭Enable SSL verification（gitlab)
```
      containers:
        - name: argocd-server
          image: 'quay.io/argoproj/argocd:v2.6.0-rc3'
          command:
            - argocd-server
            - --insecure #添加此行
```
- 创建webhook,[gitee](https://gitee.com/mckj-zhangxk/argocd_demo/hooks),[gitlab](https://git.baijiashilian.com/LLL/gloud/argocd_demo/-/hooks)
```
github,gitlab的设置里面都有webhook的配置

webhook api:http://114.250.41.119:31460/api/webhook
```