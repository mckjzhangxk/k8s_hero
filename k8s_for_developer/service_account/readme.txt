1.user(administrator,developer) 和service(jenkins,Prometheus) 2种
2. kubecrl create serviceaccount xxxx
3. 创建sa的时候，会伴随 生成 一个 token,这个token 是一个secret
4. token 可以通过 volumn 挂载到pod上，默认是挂载default的token,当然也可以把创建的sa挂载
到第三方应用pod上，第三方pod可以获得 kubenetes的授权。
5. 每个命名空间 都会有 默认的sa