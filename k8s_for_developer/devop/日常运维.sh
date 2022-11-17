# 从control 打印加入命令 
kubeadm token create --print-join-command
kubeadm reset # 加入前重置
kubeadm join 10.16.31.253:6443 --token f05gvk.ljmh4fgjirr3i499 --discovery-token-ca-cert-hash sha256:da18e99aa8a87ac9cf1bf86ea2ffa0fafb10cf7cfeb85b24c1d01686f3633bf5
