docker 默认会创建 3个 网络

    bridge:172.17.0.0/16
    null
    host:本机网络

我们可以使用如下命令：

    docker network ls //显示全部的网络

    docker inspect bridge //检查网络

    docker network create --driver bridge --subnet 192.168.0.0/16 mynetwork//创建新的网络

    docker run ubuntu --network mynetwork //运行的指定一个网络
注意：docker-compose 默认会创建【独立的网络】，例如 boombub-default,emqx-default,网络直接是不通的！

Embed DNS
    在一个容器访问 另外一个容器的时候，只需要指定【容器名称】,但是这个embed对 默认的bridge 补齐作用，只有对自定义的起作用。

    //container1,container2加入相同的网络
    docker network connect mynet container1
    docker network connect mynet container2
    //验证一下
    docker exec  container1 ping container2
    docker exec  container2 ping container1
    //清理工作
    docker network disconnect mynet container1
    docker network disconnect mynet container2
    docker network rm mynet