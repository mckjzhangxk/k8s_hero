1.k8s的用户有几种？
    user(administrator,developer) 和service(jenkins,Prometheus) 2种

2.pod上的应用想调用api-sever可能吗？
    调用apiserver,如get nodes,get pod,都需要权限， 我们从RABC制度，权限是
    绑定给用户的，这也是 k8s每个pod都会 绑定一个serviceAccount运行的原因。

3.一个有权限的用户如何访问api server?
    被认证通过的account，会有 ang验证的cert,privK,以及root ca，把这些作为参数，传给curl?

    或者把这些参数转换成一个token，放到http header中，携带者这个token去调用api.

4. 创建sa的时候，会伴随 生成 一个 token,这个token 是一个secret，**经过base64解码后，成为一个jwt对象**
    kubecrl create serviceaccount xxxx
    kubecrl list secret


5. token 可以通过 volumn 挂载到pod上，默认是挂载default的token,当然也可以把创建的sa挂载
到第三方应用pod上，第三方pod可以获得 kubenetes的授权。
```
    /var/run/secrets
```
5. 每个命名空间 都会有 默认的sa,由于那些没有指定sa的用户使用，这些sa，权利很小，只有少数
api可以被访问。


**<font color="red">6.如何把sa.cert,sa.key转换成token</font>**
```
    kubectl create token dashboard-sa
```
**<font color="red">7.更改默认sa</font>**
```
    # 更新格式resource/name
    kubectl set sa deploy/web-dashboard dashboard-sa
```
**<font color="red">8.sa作用于pod范围而不是容器范围！ </font>**

8.观察到的不同的用户账号的命名，组命名

administrator: system:master
kubelet: system:nodes:
sa: system:serviceaccount:default:default
| A | C | C |
|：   |  |
|ss |