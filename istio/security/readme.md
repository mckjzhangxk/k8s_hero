istio的安全从以下几个方面展开

* Authenication:证明你是你
    * 服务之间的通信 要有 自己证明自己身份的能力:PeerAuthentication.mtls
    * 用户 到ingressgateway: jwt,google...
* Authorization
* Certificate Manage


## [Authenication](peerAhthentication.yaml)

* 服务级别的Authenication: 访问某个服务，用户需要先证明自己是自己
* 命名空间级别的Authenication:命名空间下，服务被访问，先认证访问者 是不是自己
* mesh grid级别的Authenication:所有自动注入的istio的服务都要求 访问者 自证身份

istioctl kube-inject -f deployment.yaml


## [Authorization](peerAhthentication.yaml)

* 服务之间，有没有权利调用本服务
* DENY,ALLOW,CUSTOM