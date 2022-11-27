https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/03-Pre-requisite-DNS.md

域名解析：
* 本地解析
* DNS服务器解析

### DNS服务器设置：

```
/etc/resolv.conf，设置了2个DNS

    nameserver 192.168.0.3 //可能是配置了内外域名
    nameserver 8.8.8.8     //知道外网域名

/etc/nsswitch.conf 记录DNS服务器解析的顺序

    //先file，后服务器
    >>  hosts:      files dns myhostname //先file，后服务器
```

### 域名的构成：

* root domain:.,有a,b,c,d,e,f,g,h几个服务器
* TLD:top level domain:.edu,.org,.com


### Search 入口

<font color="red">如果在/etc/resolv.conf，中的search入口表示，搜索域名时候，可以尝试加入后缀，这点很重要，比如namesapce 下的service之间就是用简称而不是全称！</font>
```
    search mycompany myhome
    >> ping web
    >> ....mycompany.web or myhome.web or myhome
```

### Record Type

A: 域名表示IP4地址， eg 39.156.66.10=>baidu.com
AAAA:域名表示IP6地址，
CNAME: 域名的别称 eat.server,hungry.server是 food.server的别称，**重命名**


### 本地自建的DNS [CoreDNS](https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/09-Networking/04-Pre-requisite-CoreDNS.md)


```
$ wget https://github.com/coredns/coredns/releases/download/v1.7.0/coredns_1.7.0_linux_amd64.tgz $ wget https://github.com/coredns/coredns/releases/download/v1.7.0/coredns_1.7.0_linux_amd64.tgz
coredns_1.7.0_linux_amd64.tgz


coreDNS的配置文件：Corefile
. {
	hosts   /etc/hosts
}

```