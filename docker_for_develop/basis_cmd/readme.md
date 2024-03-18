新的 命令行 规则

docker \<docker-object\> <sub-cmd> [options] [CMD/Argument]

options: docker 子命令的参数
Argument:  docker 容量内应用的参数

```sh
Example:
(1) docker  container create ubuntu --name myos
(2) docker  container start myos
(3) docker container ls
    docker container ls -a
    docker container ls -q  //只显示id,很有用 的命令
(4) docker container rename httpd webapp //重命名 容器

```

run =create + run

    docker container run -itd ubuntu
    docker container attach xxx
1)t 表示终端，i表示交互，也就是 给容器一个交互的终端!
2)ubuntu 默认 提供的是/bin/bash,这个shelll  会在终端执行

Shell 与 Termininal 的区别(https://www.geeksforgeeks.org/difference-between-terminal-console-shell-and-command-line/)

A.Shell是 脚本命令 的【解析器】，和python一样
B.终端 是负载输入输出的,把【输入】->[shell]->【输出】,把【输出】显示出来。

常用命令

docker system info //可用于查看 cgroup,logging driver, Registry Mirrors
docker version