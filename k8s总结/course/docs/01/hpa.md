- 基于cpu 扩容的设置resource limit
- HPA
- msms基于带宽的扩容
```

                 ┌──────────┐                       ┌───────────┐
                 │Prometheus│                       │Kubernetes │
                 │  服务器  │                         │API 服务器 │
                 └─────┬────┘                       └──────┬────┘
                       │                                    │
                       │                                    │
                       │                                    │
┌──────────────────────▼───────────────────────┐  ┌─────────▼─────────┐
│             Prometheus Adapter               │  │  自定义指标 API  │
├──────────────────────┬────────────────────── ┤  │API 服务器 / HPA   │
│       指标 API         │     Kubernetes API   │  └─────────┬─────────┘
│   （Prometheus Query）  │   资源指标           │            │
│（Prometheus Aggregation）│  Kubernetes 聚合    │            │
├──────────────────────┼──────────────────────┤            │
│     Prometheus 聚合     │    Kubernetes 资源指标   │            │
└──────────────────────┴──────────────────────┘            │
                                                             │
                                                             │
                                                  ┌──────────▼───────────┐
                                                  │ Kubernetes Node     │
                                                  │Exporter / cAdvisor   │
                                                  └─────────────────────┘
```
这个图包含了以下组件：

Prometheus 服务器：收集和存储来自 Kubernetes 系统和其他应用程序的指标。
Kubernetes API 服务器：提供了一种与 Kubernetes 系统交互的方式，包括获取 Kubernetes 对象、操作 Kubernetes 资源等。
Prometheus Adapter：作为一个 Kubernetes 的 Deployment，通过对 Prometheus 服务器上的指标进行聚合和转换，为 Kubernetes 提供一个基于资源和自定义指标的 API。
自定义指标 API：暴露了一个基于 Kubernetes 资源和自定义指标的 API，供 Horizontal Pod Autoscaler（HPA）等 Kubernetes 控制器使用。
Kubernetes Node Exporter/cAdvisor：在每个 Kubernetes Node 上运行的代理，收集节点级别的指标，并将其暴露给 Prometheus 服务器

## 基于cpu 扩容的设置resource limit
[参考](../03-Scheduling/12-Resource-Limits.md)

## HPA

Kubernetes（k8s）中的HPA（Horizontal Pod Autoscaler）是一个自动扩展控制器，它可以根据应用程序的负载变化自动调整Pod的副本数量，以保持应用程序的稳定性和性能。

HPA通过监控指定的Pod组的CPU利用率或自定义指标，自动增加或减少Pod的数量。当CPU利用率或自定义指标高于或低于特定的阈值时，HPA会自动调整Pod的数量以适应负载变化。这使得应用程序可以快速响应变化的负载需求，同时确保资源的有效使用和成本的优化。

```yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: sentinel-deployment
  namespace: test-bj
spec:
  maxReplicas: 200
  minReplicas: 1
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: sentinel-deployment
  targetCPUUtilizationPercentage: 80 #相对limits的cpu的百分比
```


## msms基于带宽的扩容

### Prometheus Adapter
Prometheus Adapter是Kubernetes中的一个自定义指标API适配器，它允许您将Prometheus监控指标暴露为Kubernetes自定义指标API。这使得您可以使用Kubernetes自定义指标API来自动扩展应用程序和HPA（水平Pod自动伸缩器）等自动扩展控制器，以根据应用程序的负载变化自动扩展Pod的数量。


在prometheus adapter挂载点configMap中，设置采集转换指标（container_network_transmit_bytes_msms_per_second）
```yaml
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: brtc-prometheus-adapter
data:
  config.yaml: |-
    rules:
    - seriesQuery: 'container_network_transmit_bytes_total'
      resources:
        overrides:
          pod:
            resource: pod
          namespace:
            resource: namespace
      metricsQuery: 8*ceil(sum(rate(<<.Series>>{pod=~"msms.*", interface=~"eth.*"}[3m])) by (pod))
      name:
        matches: ^(.*)_total$
        as: ${1}_msms_per_second
```

自定义带宽入网指标,采集来自brtc-monitor命名空间下的 brtc-prometheus-adapter服务。
```yaml
apiVersion: apiregistration.k8s.io/v1
kind: APIService
spec:
  service:                         
    name: brtc-prometheus-adapter
    namespace: brtc-monitor
  group: custom.metrics.k8s.io
  version: v1beta2
  insecureSkipTLSVerify: true
  groupPriorityMinimum: 100
  versionPriority: 100

```

msms的hpa配置
```yaml
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: msms-deployment
  namespace: test-bj
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: msms-deployment
  minReplicas:  "3"
  maxReplicas: "200"
  behavior:
    scaleDown:
      selectPolicy: Disabled
  metrics:
  - type: Pods
    pods:
      metric:
        name: container_network_transmit_bytes_msms_per_second 
      target:
        type: Value
        averageValue: 8000000000
```