# DNS in Kubernetes



## Pod DNS Record

- 一个Pod的域名 规则

```
<POD-IP-ADDRESS>.<namespace-name>.pod.cluster.local
```
> Example
```
# Pod is located in a default namespace

10-244-1-10.default.pod.cluster.local
```

```
# To create a namespace
$ kubectl create ns apps

# To create a Pod
$ kubectl run nginx --image=nginx --namespace apps

# To get the additional information of the Pod in the namespace "apps"
$ kubectl get po -n apps -owide
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE     NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          99s   10.244.1.3   node01   <none>           <none>

# To get the dns record of the nginx Pod from the default namespace
$ kubectl run -it test --image=busybox:1.28 --rm --restart=Never -- nslookup 10-244-1-3.apps.pod.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      10-244-1-3.apps.pod.cluster.local
Address 1: 10.244.1.3
pod "test" deleted

# Accessing with curl command
$ kubectl run -it nginx-test --image=nginx --rm --restart=Never -- curl -Is http://10-244-1-3.apps.pod.cluster.local
HTTP/1.1 200 OK
Server: nginx/1.19.2

```

## 一个service的域名 规则

- The following DNS resolution:

```
<service-name>.<namespace-name>.svc.cluster.local
```

