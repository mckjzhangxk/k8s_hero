Rest API
```
curl https://10.16.31.251:6443/api/v1/nodes/bjy-idc-brtc-laliu-test0203 \
--insecure \
--key admin.key \
--cert admin.crt \
--cacert ../idc-pki/ca.crt #可以不加


```

kubectl --kubeconfig ./kubeconfig config view
或者配置成kubeconfig文件
[kubeconfig](kubeconfig)
