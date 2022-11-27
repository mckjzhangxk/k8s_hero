## istioctl
curl -L https://istio.io/downloadIstio | sh -
[安装包下载](https://github.com/istio/istio/releases/)


 

istioctl verify-install

<!-- 安装istio -->
 

```
cd istio-1.16.0
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y

✔ Istio core installed                                                                                   
✔ Istiod installed                                                                                       
✔ Egress gateways installed                                                                              
✔ Ingress gateways installed                                                                             
✔ Installation complete    
```