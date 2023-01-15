### 专业术语
| 名称| 解释| 
| -  | -| 
| application  | k8s的 manifest 文件组.| 
| application source type  | 用于部署application的 tool,eg: helm..| 
| target stauts  | git source 中定义的expect status| 
| living stauts  | k8s当前的status|
### 安装argocd

[文档](https://github.com/argoproj/argo-cd/releases)

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.6.0-rc3/manifests/install.yaml
```

查询初始化密码：
```
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}"|base64 -d
```

###  通过CLI访问
```
brew install argocd

//linux 
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

//测试
argocd login 10.16.31.253:38682
argocd app list
//部署的集群
argocd cluster list 
```


###创建application
```
 argocd app create [projectName] \
    --repo https://github.com/sid/app-1.git \
    --path [相对如repo的 目录] \
    --dest-namespace [namespaces name] \
    --dest-server https://kubernetes.default.svc

eg:
 argocd app create solar-system-app-2 \
    --repo "https://3000-port-55025db2fd8f490f.labs.kodekloud.com/bob/gitops-argocd.git" \
    --path "./solar-system" \
    --dest-namespace solar-system \
    --dest-server https://kubernetes.default.svc

//手动同步部署
argocd app sync [projectName] 
```
