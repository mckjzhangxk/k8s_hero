[Tutorial](https://jhooq.com/prometheous-grafan-setup/)
[Tutorial k8s](https://jhooq.com/prometheous-k8s-aws-setup/#8-install-grafana)
### prometheus组件

#### prometheus Core组件:
* StorageDB(TSDB):时序数据库，存储cpu,memory...
* Retrieval:定时去pull metrics数据，存入TSDB
* HttpServer: PromSQL,UI... 
#### 服务发现机制：
* scrap config：静态配置
* 服务发现:discover targets

#### AlertManager:
当某个alert rule被满足，Server会把事件推送给 AlertManager,AlertManager发送邮件，。。

### Target

Prometheus监控的对象叫target,
Unit of monitor: metrics data
```
应用需要暴露的端口
    http://hostname/metrics
```

### Pull Model Vs Push Model
* prometheus 想target发送请求，获得metrics data.
* Pushgateway: 让prometheus以push方式工作。

### Exporter:
* 从target上拉取metrics，交给到Prometheus的Retrieval
* 集成到自己的服务中,go,java...
* 常用的比如：node-exportor


### 配置prometheus

* prometheus.yaml文件
* rule_files: 用于定义规则，报警规则或者 聚合metrics规则
* global_interval: 多少秒抓取一次 metrics。。。 
* scrape_config: **target的配置，Job定义在此处**


### promQL [video tutorial](https://www.youtube.com/watch?v=hvACEDjHQZE)
#### Data Type
1) counter
2) Gauge：可增，可减
3) histogram
4) summary
* 与grafana配合使用，grafana使用promQL查询数据，建立 dashboard
#### Metrics format
1) string
2) scalar
3) range Vector: 区间内的某个值，vector表示多实例
4) instance Vector: 一个时间点上的区间内的某个值，vector表示多实例

#### Filter Data
[正则表达式](https://prometheus.io/docs/prometheus/latest/querying/basics/#time-series-selectors)：

|符号| 正则| 含义
| - | - | - |
| = |否|相等
| !=|否|不相等
| =~|是|相等
| !~|是|不相等
label filter
```
 node_memory_MemAvailable_bytes{job="job1"}
```

range Filter
```
//统计counterName 5分钟内的指标，返回的是range Vector
counterName[5m]
```

modifier:从每个时间点开始计算
```
#1609756000 时间点的前5分钟
counterName[5m]@1609756000
```

函数(operator)
 ```
//统计counterName 此时此刻的指标，返回的是instance Vector
counterName
```



$rate=\frac{s_n-s_1}{t_n,t_1}$
```
统计 counterName 在5分钟内的指标的 scope,5分钟内至少有 2个采样点，返回的是instance Vector
rate(counterName[5m])
```

```
统计可以资源的平均值，返回的是instance Vector
avg_over_time(node_memory_MemAvailable_bytes[10m])
```

aggregation: 
```
count (metrics) by (label)
sum (metrics) by (label)

eg:
count(kube_pod_status_phase{phase="Failed"}) by(namespace)
```
binary
```
```
### 使用Operator简化配置
[video](https://www.youtube.com/watch?v=LQpmeb7idt8)
[docs](https://prometheus-operator.dev/docs/user-guides/getting-started/#deploying-prometheus)

