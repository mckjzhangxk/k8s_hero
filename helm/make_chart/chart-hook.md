P150页


* 执行heml命令
 > root\>helm upgrade my-release ./brtc后 helm执行的流程
```
|vertify|  -> |render|-> |prehook_i|...->|k8s|->|posthook_i|..

vertify: 验证yaml的语法，template表达式的语法的正确性
render:替代template variable
prehook_i：可以由多个 更新前的操作
posthook_i：可以由多个 更新后的操作
```


* 设置hook的方法：

```
apiVersion: batch/v1
kind: Job
metadata:
  name: bachup-db
  annotations:
     "helm.sh/hook": pre-install
     "helm.sh/hook": post-install
     "helm.sh/hook": pre-delete
     "helm.sh/hook": post-delete
     "helm.sh/hook": pre-upgrade
     "helm.sh/hook": post-upgrade
     "helm.sh/hook": pre-rollback
     "helm.sh/hook": post-rollback

     "helm.sh/hook-weight": "5" #权重决定执行顺序，小的早于大的执行
     "helm.sh/hook-delete-policy": hook-succeed  
```
* 对于hook job的删除策略：
hook-succeed :成功会删除
hook-failed :总会会删除
before-hook-creation： 下次更新删除上次的
