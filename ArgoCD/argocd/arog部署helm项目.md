
可以使用以下命令，从git上拉取,创建一个helm app
```sh
argocd app create brtc-monitor \
--repo https://gitee.com/mckj-zhangxk/brtc-monitor.git \
--revision master \
--path . \
--dest-server https://kubernetes.default.svc \
--values values-prod.yaml
```

对于的k8s resource文件
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: monitor-brtc
  namespace: argocd
spec:
  destination:
    server: https://kubernetes.default.svc
  project: default
  source:
    helm:
      valueFiles:
      - values-prod.yaml
    path: .
    repoURL: https://gitee.com/mckj-zhangxk/brtc-monitor.git
    targetRevision: HEAD

```