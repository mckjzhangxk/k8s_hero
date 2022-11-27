P121

[destination-Rule](https://istio.io/latest/docs/reference/config/networking/destination-rule/)

## Destination-Rule

Destination-Rule重要定义的是 相对于 virtual service的 route.detination的规则的模板，
如果route.detination.subset设置了,那么就需要定义一个对应的Destination-Rule.

Destination-Rule 决定路由到下游服务的时候，那些流量可以被接受，流量怎么分发？
- [ ] Traffic Policy：来自于那些流量，负载均衡策略？
- [ ] Subset：流量怎么分发