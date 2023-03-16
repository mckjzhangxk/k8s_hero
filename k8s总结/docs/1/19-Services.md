# Kubernetes Services



  
#### Let's look at some other aspects of networking
 ## Service Types
 
 #### There are 3 types of service types in kubernetes
 
   ![srv-types](../../images/srv-types.PNG)
- ClusterIp内部的负载均衡器
- NodePort 临时的外网访问方式
- LoadBalancer slb代理，生产环境外网访问方式

```
kubectl get svc -n test-sh mpc-service

//LoadBalancer
curl http://10.16.31.250:8081/health

//NodePort
curl http://10.16.31.249:39811/health
curl http://10.16.31.250:39811/health
curl http://10.16.31.251:39811/health
curl http://10.16.31.252:39811/health
curl http://10.16.31.253:39811/health
```

## External Communication
- 任意nodeip +nodeport
- LoadBalancer Ip+ servicePort
- How do we as an **`external user`** access the **`web page`**?

  - From the node (Able to reach the application as expected)
  
    ![srv2](../../images/srv2.PNG)
    
  - From outside world (This should be our expectation, without something in the middle it will not reach the application)
  
    ![srv3](../../images/srv3.PNG)



## Service Port
- In this case the service creates a **`Virtual IP`** inside the cluster to enable communication between different services such as a set of frontend servers to a set of backend servers.
    
    ![srvc1](../../images/srvc1.PNG)
    
#### What is a right way to establish connectivity between these services or tiers  
- A kubernetes service can help us group the pods together and provide a single interface to access the pod in a group.

  ![srvc2](../../images/srvc2.PNG)
  
  