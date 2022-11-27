P121

##[virtual-service](https://istio.io/latest/docs/reference/config/networking/virtual-service/)

介于ingress-gateway与service之间的虚拟对象，负责
- [ ] 服务的路由:match-route
- [ ] 流量分发，版本控制，负载均衡:host,port,sesubset,weight,


### 配置规则：Match And Route and destination

每一个服务的路由规则分为
* match: 定义多条匹配规则,都用于匹配后台 service
* route: **定义同一个服务的 不同版本destination**
* destination: 定义后台（服务,端口）,subset，流量控制weight


```
    #来组ingressgateway的流量，匹配url1,url2都会被路由。
    ingressgateway-->match[url1,url2]->route[dest1,dest2]

    #一个
    dest: 
        -->subset:v1,weight:30
        -->subset:v2,weight:40
        -->subset:v3,weight:30
```

###Virtual Service 对比 ingress

|   | Ingress | Virtual Service |
| - | - | - |
| 路径匹配 | 一个host,path匹配对应一个service  |一个host,多个path匹配对应一个route
|目的地|服务名+服务端口|多目的地，目的地由(服务名+服务端口+subset,weight)组成
|服务之间|-|可以用于定义服务之间流量，比如portal->review


常用命令
```
    kubectl get virtualservice
    
```