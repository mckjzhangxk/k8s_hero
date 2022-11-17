(1)docker 默认使用root 允许的,root的权限可以查看
  cat /usr/include/linux/capability.h

(2) docker run --cap-add nginx
    docker run --cap-drop
    docker run --privileged nginx