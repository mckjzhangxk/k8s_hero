## ani-affinity注意事项

如下配置经常让我迷惑，假设有5台机器：

|服务|Anti-Rule|节点
|-|-|-|
| mpc-bj| msms-pod|node1,node2,node5
| mpc-sh| msms-pod|node2
| msms-bj| msms-pod|node3
| msms-sh| msms-pod|node4


sh,bj的msms都不可能有分配空间了，因为如果给msms分配了node1,noe2,node5,那么 之前在这几台机器上的 mpc 就会 不满足 设置的【没有 msms-pod 的规则】。


