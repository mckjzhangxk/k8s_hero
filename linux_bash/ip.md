```sh
ip [option] object
object: address,link,route
```

## link

```sh
# state up/down,mtu 1500
ip link show


```

## address

```sh
# scope globel表示静态ip
ip address show
ip -br address show
# 加颜色
ip -br -c address show

ip --one-line|column -t 

```

## route
### route tables
- 1-2^31的编号，一般在/etc/iproute2/rt_tables保存索引。
- 常用的 main->254,local->255
- <font color=red>local 表决定哪些地址是local,在这个表中定义的ip,kernel会映射成本机程序</font>
- 非local的ip地址，kernel参考 main, 如果main表没有给出路由规划，那么参考default.
```sh
# 查看main表
ip route show table main
ip route show table 254
# 查看local表
ip route show table local
ip route show table 255

ip route show all
```

### route tyoe
- unicast: 描述到某个目标的路由规则
- local： 描述哪些ip地址是分配给本地host
- broadcast

```sh
ip -4 route show table all type unicast
ip -4 route show table all type local
ip -4 route show table all type broadcast
```

### 其他重要的属性
- dev: 规则关联的设备
- src: 表示当使用选定路由发送数据的使用，优先选择哪个地址作为src ip?
```sh
# eg 以下是openwrt的main route:
# 1.如果网10.0.4.0/24发送数据包，使用srcip=10.0.4.37
# 2.如果网192.168.19.0/24发送数据包，使用srcip=192.168.19.1
# 3.如果其他情况0.0.0.0/0,还是使用srcip=10.0.4.37

# default via 10.0.4.1 dev eth1 proto static src 10.0.4.37
# 10.0.4.0/24 dev eth1 proto kernel scope link src 10.0.4.37
# 192.168.19.0/24 dev br-lan proto kernel scope link src 192.168.19.1
```
- scope: 有global,link,host三种，默认情况是根据以下原则进行划分
- - global:对于unicast的route,一般是直连某个地址，或者default
- - link:对于某个子网段规则，，比如 10.0.4.0/24，这样的由于，
- - host:对于local的route
```sh
ip -4 route show table all scope global
ip -4 route show table all scope link
ip -4 route show table all scope host
```
- protocal: 
- - kernel系统默认设置： 比如127.0.0.1,127.0.0.1/8,某个网段的网关
- - boot: 我手动设置的是这种？  
- - static:默认的路由规则ß
```sh
ip -4 route show table all  proto kernel
ip -4 route show table all  proto boot
ip -4 route show table all  proto static
```
### 添加路由规则
- 语法 ip route add to [TYPE] [PREFIX] ....
- TYPE如果不设置认为是unicast,
- PREFIX: eg: default=0.0.0.0/0, 192.168.1.1/24
- to也可以省略
```sh
# 以下全部等价
ip route add 0.0.0.0/0 via 192.168.0.1
ip route add to 0.0.0.0/0 via 192.168.0.1
ip route add to unicast 0.0.0.0/0 via 192.168.0.1
ip route add default via 192.168.0.1

# 网type local中添加 所以ip地址
ip route add local 0.0.0.0/0 dev lo

```