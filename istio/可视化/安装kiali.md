kubectl apply -f samples/addons

检查是否安装完成
kubectl get svc -n istio-system


//打开kiali界面
❯ istioctl dashboard kiali


//创建流量
1.gateway:
    kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
2.查看ingressgateway 的ingressport
    kubectl get svc -n istio-system istio-ingressgateway -o yaml  //注意，可以修改成nodeport!,http2
3.curl http://10.16.31.253:28264/productpage //神奇吧，这规则怎么来的呢？

3.1 sh auto_curl.sh
4.kubectl delete deployment productpage-v1