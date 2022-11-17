(1) docker image tag nginx myweb:mynginx //创建一个软连接
eg:
    docker image tag httpd:latest harbor.baijiayun.com/training-test/httpd:my
    docker push harbor.baijiayun.com/training-test/httpd:my
(2) 登录 harbor.baijiayun.com
  docker login harbor.baijiayun.com //zhangxiaokai/Bai2021
  我就可以把我的镜像 push上去了


