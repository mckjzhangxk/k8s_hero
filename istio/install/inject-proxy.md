
demo:
istio-1.16.0/samples/bookinfo/platform/kube/bookinfo.yaml

istioctl analyze  
自动注入
kubectl label namespace brtc-test-latest istio-injection=enabled
