kubectl get roles
kubectl get rouebindings

#验证 权限访问命令
kubectl auth can-i create deployments

kubectl auth can-i delete nodes


kubectl auth can-i create deployments --as dev-user
kubectl auth can-i create pod --as dev-user --namespace brtc-test-latest

kubectl auth can-i delete nodes --as dev-user
