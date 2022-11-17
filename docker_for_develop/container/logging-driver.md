(1)查看 系统 的logging-driver,支持的 driver
    docker system info|grep logging
    docker system info|grep -C 5 Plugin
(2)设置容器的logging-driver,用于 覆盖系统的
    docker run -itd --rm --log-driver=journal nginx
(3) 修改系统的logging-driver
    vi /etc/docker/daemon.json

    {
        "debug": true,
        "hosts": ["tcp://192.168.1.10:2376"]
        "tls": true,
        "tlscert": "/var/docker/server.pem",
        "tlskey": "/var/docker/serverkey.pem"，
        "log-driver": "awslogs",
        "log-opt": {
            "awslogs-region": "us-east-1"
        }
    }
     systemctl reload docker

Reference:
https://docs.docker.com/compose/reference/envvars/
https://docs.docker.com/config/containers/logging/configure/