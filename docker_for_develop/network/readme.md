https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/06-Pre-requisite-Docker-Networking.md

### docker 默认会创建 3个 网络

* bridge(docker0):172.17.0.0/16:虚拟网络
    ```
        ip link add mybridge type docker0
        ip addr add 172.17.0.1/16 docker0

        docker0对宿主机来说是 interface，有ip=172.17.0.1
        docker0虚拟网络是switch，(虚拟网卡的网线都插在 switch上）
    ```
* null:无网络
* host:本机网络

* 常用命令
```
    docker network ls //显示全部的网络

    docker inspect bridge //检查网络

    docker network create --driver bridge --subnet 192.168.0.0/16 mynetwork//创建新的网络


    docker run --network host nginx
    docker run ubuntu --network mynetwork //运行的指定一个网络
```

注意：docker-compose 默认会创建【独立的网络】，例如 boombub-default,emqx-default,网络直接是不通的！

### docker 启动应用背后的logic

```
    docker run ubuntu -p 8080:80

    1)创建namespace,ip netns查看，需要一些hack，查看文档
    2)创建 一对vethA,vethB,vethA到namespace,vethB到 docker0中
    3)设置本机路由表，凡是访问本机，目标是8080的，全部转到 docker0 网络的80端口
    $ iptables \
         -t nat \
         -A PREROUTING \
         -j DNAT \
         --dport 8080 \
         --to-destination 80
    $ iptables \
      -t nat \
      -A DOCKER \
      -j DNAT \
      --dport 8080 \
      --to-destination 172.18.0.6:80   
```
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