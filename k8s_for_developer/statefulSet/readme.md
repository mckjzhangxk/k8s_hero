# stateful创建的pod 有如下特点

* 每个pod命名唯一，固定都是一个index
* pod创建的顺序 固定
* 扩容 是按照 pod index  升序创建 pod
* 缩容 是按照 pod index  逆序删除 pod
* 必须指定 serverName


# HeadlessService

* 只为一个pod提供 域名，没有任何负载功能