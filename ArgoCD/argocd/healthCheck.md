* 对于不同的resource,argocd有不同的 检查health策略
* 可以自定义health此类，以configMap为例子,P42
```
kubectl edit configmap -n argocd argocd-cm

```
data: resource.customizations.health.ConfigMap:lua脚本
```lua
hs = {}
hs.status = "Healthy"
if obj.data.TRIANGLE_COLOR == "white" then
hs.status = "Degraded"
hs.message = "Use a different COLOR"
end
return hs
```


```lua
data: resource.customizations.health.Prometheus:

hs = {}
hs.status = "Healthy"
return hs
```