
### 概念：

* Table: 内核中的表格，用于过滤处理进出入的数据包，常用的有filter,nat
* Chain(Hook Point): 不同的表有不同的Chan,在这里 Chain中，一定一条一条的rule.
```
常用：Nat表，PREROUTING,POSTROUTING,OUTPUT,它的目的是修改数据包的源或目标地址

    eth0 -> |PREROUTING| ->app1
                |          |
                |
                |        |OUTPUT|
                |           |
    eth1 <- |POSTROUTING|<-app2
```
* Chain Rule:rule是对数据包的匹配规则，如果匹配，跳到对应的jump上，否则执行下一个rule
* Jump: 设置规则的时候，如果匹配，跳转到对应的target上
* target: 可以理解为动作，对数据包的操作
```
常用:
    DNAT:对数据包【目标地址，端口】的修改
    SNAT:对数据包【源地址，端口】的修改
        - static source ip替换
        - dynamic source ip替换,masourade
    REDIRECT:重定向端口

    REJECT:
    ACCPPT:
```


### 常用命令总结
```
    iptables -t nat -L [ChanName]              //查看某个chain
    iptables -t nat -A [ChanName]              //追加某个chain
    iptables -t nat -R [ChanName] [rulenum]    //替代某个chain的第rulenum个rule
    iptables -t nat -D [ChanName] [rulenum]    //追加某个chain的第rulenum个rule
```


```
rule match规则
    --source 192.168.0,0/16
    --destination 192.168.0,3 #匹配目标ip
    --protocal udp
    --dport 80  #匹配目标端口
```

| Target | Parameter | Chain |
| - | - | - |
|REDIRECT|--to-ports| nats.PREROUTING



###Example

eg1:把来自 1024端口的数据包，重定位到8000端口的服务器
```
#1.启动服务器： netcat -l 8000
#2.设置路由表
   iptables -t nat \ 
            -A PREROUTING \
            -p tcp \
            --dport 1024 \    #规则结束
            -j REDIRECT \
            --to-ports 8000   #jump结束
#3.启动客户端验证： netcat zz02 1024
```

eg2:外网 请求 docker 网络中的服务

```
#1.创建虚拟网络；docker run --name=private_net --rm -d ubuntu sleep 3600 
# apt install -y netcat net-tools iputils-ping

#2.检查 private_net的地址
# docker inspect private_net --format="{{json .NetworkSettings.IPAddress}}"

#3 docker内部启动服务
netcat -l 9999
#4
iptables  -t nat -A PREROUTING -p tcp  --dport 1024 -j DNAT --to-destination 172.18.0.2:9999

```



##  FILTER 防火墙配置
- INPUT: 收到的数据包dst_ip是本机
- FORWARD:收到的数据包dst_ip不是本机，表示本机是一个转发节点，比如路由器。
- OUTPUT 发出的数据包src_ip是本机
```sh
# A.icmp的禁用 

# 加入到INPUT的第一条规则，允许icmp
iptable -I INPUT 1 -p icmp -j ACCEPT
# 删除
iptable -D INPUT 1 -p icmp -j ACCEPT
iptable -L INPUT


# B.自定义规则的生成,没有尝试
iptables -N MYCHAIN
# 随便添加规则
iptables -A MYCHAIN -s 192.168.1.100 -j ACCEPT
# 输入流量中应用 MYCHAIN 中的规则
iptables -I INPUT -j MYCHAIN


# C.外网想访问内网
# 外网-192.168.126.0/24 内网 -192.168.1.0/24
# 设置外网机器 路由表
ip route add 192.168.1.0/24 via   192.168.126.167
# 内网机器(192.168.126.167)允许转发
# eth0是来自外网192.168.126.0/24的流量
iptables -I FORWARD 1 -i eth0 -j ACCEPT
```

## Mangle 表:
- 这个表主要用于修改数据包的头部信息