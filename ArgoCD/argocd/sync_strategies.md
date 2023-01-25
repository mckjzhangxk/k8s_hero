### 有三种策略把git的配置同步到k8s（P44）

|策略| 说明| |
| - | - | - |
| automatic or mannual | 追加git的reource,修改resource的change| - |
| auto-prune | 删除git中resource的删减 | - |
| self-heal | 恢复git意外的操作，kubectl对k8s的操作会被恢复 | self-heal不适用于扩容 |



example:

1.开启self-heal后，版本cli从v1改成v6,会被argocd恢复到v1
2.开启auto-prun，删除git中的svc，argocd会删除k8s对应的资源
