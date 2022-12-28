# 名字强制是  alertmanager-${name}
kubectl delete secret -n brtc-monitor  alertmanager-alertmanager-brtc 
kubectl create secret -n brtc-monitor generic alertmanager-alertmanager-brtc --from-file=alertmanager.yaml