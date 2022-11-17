P116

常用kubectl 命令：
* kubectl config view #查看当前的 kubeConfig文件
* kubectl config current-context #查看当前的 context
* kubectl config --kubeconfig /root/my-kube-config  use-context 【my-kube-config下contextName】 #指定Config，并且设置使用的context
* 
    kubectl get pod 
        --server  http://xxx:6443
        --client-key admin.key
        --client-certificate admin.crt
        --certificate-authority ca.crt
* kubectl get pods --kubeconfig my-config  #使用指定的kubeConfig文件 去链接k8s


