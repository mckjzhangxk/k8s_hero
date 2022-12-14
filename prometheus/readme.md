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


### promQL
#### Metrics Type
1) counter
2) Gauge：可增，可减
3) histogram
4) summary
* 与grafana配合使用，grafana使用promQL查询数据，建立 dashboard

string
scalar
range Vector: 区间内的某个值，vector表示多实例
instance Vector: 一个时间点上的区间内的某个值，vector表示多实例

### 使用Operator简化配置
[video](https://www.youtube.com/watch?v=LQpmeb7idt8)
[docs](https://prometheus-operator.dev/docs/user-guides/getting-started/#deploying-prometheus)


