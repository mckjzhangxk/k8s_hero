# Ingress
**Ingress**
Kubernetes Ingress是一种用于在Kubernetes集群中暴露HTTP和HTTPS服务的API对象。它提供了一种简单而有效的方法来将流量路由到Kubernetes中部署的不同服务。Ingress可以管理负载均衡、路由规则、TLS终止和其他常见的服务发现和路由需求。

Ingress通常通过使用Nginx或Traefik等Ingress控制器来实现。这些控制器负责将Ingress规则转换为实际的负载均衡器配置，并确保流量被正确路由到相应的服务。此外，Ingress还可以配置SSL证书和基于主机名的路由规则，以便将流量发送到正确的后端服务。

- Ingress Controller(略)
- Ingress Resources


Ingress Controller 是 Kubernetes 集群中的一个单独的组件，它实现了 Ingress 规范，用于将外部流量路由到 Kubernetes 集群中的 Service。Ingress Controller 可以使用不同的负载均衡器和路由算法来管理入站流量，并将其转发到 Kubernetes 集群中的不同 Service。

Ingress Resource 是 Kubernetes 中的一个资源对象，它定义了将外部流量路由到 Kubernetes 集群中的 Service 的规则。 Ingress 规则定义了 Ingress Resource 应该如何将流量路由到不同的 Service 和路径，以及如何将 TLS 加密应用到入站流量上。

换句话说，Ingress Resource 提供了一种声明性的方式来定义负载均衡和路由规则，而 Ingress Controller 则是负责将这些规则应用到集群中的实际负载均衡器和路由器上。

## Ingress Resource - Rules

- 1 Rule and 2 Paths.

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-wear-watch
spec:
  rules:
  - http:
      paths:
      - path: /wear
        backend:
          serviceName: wear-service
          servicePort: 80
      - path: /watch
        backend:
          serviceName: watch-service
          servicePort: 80
```
- Describe the earlier created ingress resource

```
$ kubectl describe ingress ingress-wear-watch
Name:             ingress-wear-watch
Namespace:        default
Address:
Default backend:  default-http-backend:80 (<none>)
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /wear    wear-service:80 (<none>)
              /watch   watch-service:80 (<none>)
Annotations:  <none>
Events:
  Type    Reason  Age   From                      Message
  ----    ------  ----  ----                      -------
  Normal  CREATE  23s   nginx-ingress-controller  Ingress default/ingress-wear-watch

```

- 2 Rules and 1 Path each.
```
# Ingress-wear-watch.yaml

apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-wear-watch
spec:
  rules:
  - host: wear.my-online-store.com
    http:
      paths:
      - backend:
          serviceName: wear-service
          servicePort: 80
  - host: watch.my-online-store.com
    http:
      paths:
      - backend:
          serviceName: watch-service
          servicePort: 80
```
