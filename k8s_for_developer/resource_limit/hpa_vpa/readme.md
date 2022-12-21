### 概念
 VPA:增加 cpu,memory 等资源,**相当于给你的pod升级 配置**
 HPA：当pod 用光设置的resource limit的时候，调整replica，增加部署的pod的数量。

### cooling time
scale up: 3minute，下次扩容时间，是在这次后3m后
scale down:15minute，缩容的时间，是等15m

### 安装VPA：METRICS SERVER部署
```
git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git

cd kubernetes-metrics-server && kubectl create -f .
```

### 安装VPA：
autoscaler 安装
```
git clone https://github.com/kubernetes/autoscaler
cd autoscaler/vertical-pod-autoscaler/hack
sh vpa-up.sh
```

### vpa,hpa的deoployment的pod都需要设置resource Limit
```
      resources:
        requests:
          cpu: 1.0 # 1.0==1000m
          memory: 250Mi
```
[VPA文档](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler#readme)


 kubectl autoscale rc foo --max=5 --cpu-percent=80
 kubectl autoscale deployment foo --min=2 --max=10