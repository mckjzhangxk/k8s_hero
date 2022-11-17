docker daemon 默认使用 IPC 监听 客户端的请求【docker CLI】
IPC=/var/run/docker.socket  内部的Unix socket


如果想从【其他主机】 CLI 访问 daemon怎么办呢？

1)让dockerd在 某个端口监听 请求

dockerd --host=tcp://192.168.1.10:2375
dockerd --host=cp://192.168.1.10:2376 --tls true --tlscert=server.pem --tlskey=key.pem

2)或者编辑/etc/docker/daemon.json

    {
        "debug": true,
        "hosts": ["tcp://192.168.1.10:2376"] //外网监听
        "tls": true,
        "tlscert": "/var/docker/server.pem",
        "tlskey": "/var/docker/serverkey.pem"
    }
3)systemctl start docker



4)客户端
docker -H "tcp://192.168.1.10:2376" ps || docker --host="tcp://192.168.1.10:2376" ps

或者export DOCKER_HOST="tcp://192.168.1.10:2376"