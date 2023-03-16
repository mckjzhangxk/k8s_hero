- CPU扩容
```yaml
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: mpc-deployment
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: mpc-deployment
  minReplicas: 1
  maxReplicas: 200
  behavior:
    scaleDown:
      selectPolicy: Disabled  #关闭自动缩容
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 80  #limit的 80%的时候触发扩容
```
- msms带宽扩容
```yaml
---
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: msms-deployment
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: msms-deployment
  minReplicas: 3
  maxReplicas: 1
  behavior:
    scaleDown:
      selectPolicy: Disabled
  metrics:
  - type: Pods
    pods:
      metric:
        name: container_network_transmit_bytes_msms_per_second #自定义的指标
      target:
        type: Value
        averageValue:  10000000 #10M带宽扩容
```

- prometheus-adapter 把 prometheus指标转换成 k8s指标
[prometheus](http://10.16.31.253:22529/graph?g0.expr=&g0.tab=1&g0.stacked=0&g0.show_exemplars=0&g0.range_input=1h)
```yaml
---
kind: ConfigMap
apiVersion: v1
metadata:
  name: brtc-prometheus-adapter

  labels:
    app.kubernetes.io/component: metrics
    app.kubernetes.io/instance: brtc
    app.kubernetes.io/name: prometheus-adapter
    app.kubernetes.io/part-of: prometheus-adapter
    app.kubernetes.io/version: v0.10.0
    kubesphere.io/creator: admin
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
```
$ kubectl get APIService v1beta1.custom.metrics.k8s.io
```