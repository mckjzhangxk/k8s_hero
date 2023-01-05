解决客户端ip透传问题，有以下方案：[参考方案](https://aws.amazon.com/cn/blogs/china/different-ways-to-get-the-real-source-ip-of-the-client-in-amazon-eks/),[external load Balancer](https://kubernetes.io/zh-cn/docs/tasks/access-application-cluster/create-external-load-balancer/)

### 1.[service 采用externalTrafficPolicy=local方式](nginx-service.yaml)

如果用采用externalTrafficPolicy=cluster的方式，结论如下：其中remote_addr 表示直接访问 node1:nodeport,日志打印的remote_addr.

externalTrafficPolicy=cluste:
| 宿主机  |  是否安装nginx pod | remote_addr |
| -     | -   | -   |
| node1 |  是  | 未知ip |
| node2 |  否  | kubeproxy-pod的ip |
| node3 |  否   | kubeproxy-pod的ip |

由此可知，externalTrafficPolicy=Cluster表示 服务会在 **引流到 集群内部的pod**


externalTrafficPolicy=local:
| 宿主机  |  是否安装nginx pod | remote_addr |
| -     | -   | -   |
| node1 |  是  | clientIp |
| node2 |  否  | 无法访问 |
| node3 |  否   | 无法访问 |

由此可知，externalTrafficPolicy=Local 可以实现透传，但是只会**引流到 本机内部的pod**，所有这里nginx需要用deamonset进行部署，避免访问不通问题。

既然有了remote_addr为真是客户端Ip,就可以设置nginx的proxy，[追加X-Forwarded-For头部](nginx.conf)。