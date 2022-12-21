# image: quay.io/prometheus/node-exporter:v1.3.1
# image: "quay.io/kiwigrid/k8s-sidecar:1.15.6"
# image: "grafana/grafana:8.5.3"
# image: "k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.4.1"
# image: "quay.io/prometheus-operator/prometheus-operator:v0.56.3"
# image: "quay.io/prometheus/alertmanager:v0.24.0"
# image: "quay.io/prometheus/prometheus:v2.35.0"
# image: "bats/bats:v1.4.1"
# image: k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1


docker pull quay.io/prometheus/node-exporter:v1.3.1 --platform amd64
docker tag  quay.io/prometheus/node-exporter:v1.3.1 harbor.baijiayun.com/prometheus/node-exporter:v1.3.1
docker push harbor.baijiayun.com/prometheus/node-exporter:v1.3.1
docker rmi -f  harbor.baijiayun.com/prometheus/node-exporter:v1.3.1


docker pull quay.io/prometheus/alertmanager:v0.24.0 --platform amd64
docker tag  quay.io/prometheus/alertmanager:v0.24.0 harbor.baijiayun.com/prometheus/alertmanager:v0.24.0
docker push harbor.baijiayun.com/prometheus/alertmanager:v0.24.0
docker rmi -f  harbor.baijiayun.com/prometheus/alertmanager:v0.24.0


docker pull quay.io/prometheus/prometheus:v2.35.0 --platform amd64
docker tag  quay.io/prometheus/prometheus:v2.35.0 harbor.baijiayun.com/prometheus/prometheus:v2.35.0
docker push harbor.baijiayun.com/prometheus/prometheus:v2.35.0
docker rmi -f  harbor.baijiayun.com/prometheus/prometheus:v2.35.0



docker pull quay.io/kiwigrid/k8s-sidecar:1.15.6 --platform amd64
docker tag  quay.io/kiwigrid/k8s-sidecar:1.15.6 harbor.baijiayun.com/prometheus/k8s-sidecar:1.15.6
docker push harbor.baijiayun.com/prometheus/k8s-sidecar:1.15.6
docker rmi  harbor.baijiayun.com/prometheus/k8s-sidecar:1.15.6


docker pull k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.4.1 --platform amd64
docker tag  k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.4.1  harbor.baijiayun.com/prometheus/kube-state-metrics:v2.4.1 
docker push harbor.baijiayun.com/prometheus/kube-state-metrics:v2.4.1 
docker rmi -f harbor.baijiayun.com/prometheus/kube-state-metrics:v2.4.1 



docker pull quay.io/prometheus-operator/prometheus-operator:v0.56.3 --platform amd64
docker tag  quay.io/prometheus-operator/prometheus-operator:v0.56.3 harbor.baijiayun.com/prometheus/prometheus-operator:v0.56.3
docker push harbor.baijiayun.com/prometheus/prometheus-operator:v0.56.3
docker rmi  harbor.baijiayun.com/prometheus/prometheus-operator:v0.56.3



docker pull k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1 --platform amd64
docker tag  k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1 harbor.baijiayun.com/prometheus/kube-webhook-certgen:v1.1.1
docker push harbor.baijiayun.com/prometheus/kube-webhook-certgen:v1.1.1
docker rmi  harbor.baijiayun.com/prometheus/kube-webhook-certgen:v1.1.1



docker pull grafana/grafana:8.5.3 --platform amd64
docker tag  grafana/grafana:8.5.3 harbor.baijiayun.com/prometheus/grafana:8.5.3
docker push harbor.baijiayun.com/prometheus/grafana:8.5.3
docker rmi  harbor.baijiayun.com/prometheus/grafana:8.5.3


# docker pull --platform amd64
# docker tag  harbor.baijiayun.com/prometheus/
# docker push harbor.baijiayun.com/prometheus/
# docker rmi  harbor.baijiayun.com/prometheus/