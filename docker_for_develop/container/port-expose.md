1) docker run -p 8080:80 nginx

2)如果只想 暴露 某个 net-interface的 端口？
  docker run -p 192.168.1.5:8080:80 nginx
  docker run -p 80 nginx //随机 使用一个本机端口作为 80的映射，eg: rndport:80
  // cat /proc/sys/net/ipv4/ip_local_port_range
3) 自动暴露端口，暴露 Dockerfile指定的端口(eg: EXPOSE 9999),

   docker run -P nginx // rndport:80
   docker run -P --expose=8080 nginx //新添加 8080

4) docker container inspect $id|grep "ExposedPorts"


5) docker  利用 linux的 iptables 实现的 NAT 映射