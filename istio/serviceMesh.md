service Mesh
由如下组成

control plane： 中心，有配置证书，流量管控，服务状态监控 等功能。

data plane: 由安装在每个服务上的 proxy组成，proxy直接互相通信。。


Istio的组件

control plane: 进程istiod，由以下三部分组成
* citadel(证书)
* polit（服务发现）
* gallery（配置文件验证）

data plane: envoy,istio-agent