### 把所有的TCP流量都转发给8000
[服务器](gateway.go)
```sh
#这条命令对【到达本机的流量】全部进行了转发，但是 如果是【本机的流量】不能被转发
sudo iptables -t nat \
            -I PREROUTING  1 \
            -p tcp \
            -j REDIRECT \
            --to-ports 8000

sudo iptables -n -t nat -L  PREROUTING
```


### 把所有的UDP流量都转发给9000
[服务器](gateway.go)
```sh
#这条命令对【到达本机的流量】全部进行了转发，但是 如果是【本机的流量】不能被转发
sudo iptables -t nat \
            -I PREROUTING  1 \
            -p udp \
            -j REDIRECT \
            --to-ports 9000

sudo iptables -n -t nat -L  PREROUTING
```

```sh
sudo iptables -t nat -N proxy_nat
sudo iptables -t nat -I PREROUTING 1 -j proxy_nat
sudo iptables -t nat -I proxy_nat 1 -m set ! --match-set ip_proxy dst -p tcp -j REDIRECT --to-ports 8000
```