https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/07-Security/19-Cluster-Roles.md

### 资源分为2中形式存在于k8s中
* [ ] namespaced:
    pods,deployments,service,configmap,role,rolebings,
    pvc,jobs
* [ ] cluster scoped:
    nodes,pv,clusterrole,clusterrolebingings,certificatesigningrequests,namespaces


### 绑定对象的说明：
* role ref
    * namespaced:可以创建namespaced的**，比如 get pods,那所有namespace下的pod 都可以被查看
    * cluster scoped
* subjects
    * kind: [User](cluster-admin-role-binding.yaml)
    * kind: [Group](more/binding.yaml)
**
clusterrole 不仅可以创建 cluster scoped的，**也可以创建namespaced的**，比如 get pods,那所有namespace下的pod 都可以被查看了

```
kubectl api-resource
```
 