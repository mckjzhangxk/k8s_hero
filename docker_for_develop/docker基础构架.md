* 1.linux namespace,linux cgroup:linux 提供的虚拟化技术。
* libcontainer docker调用ns,cgroup的基本库
* runc:运行OCI 容器的执行环境
* containerd:容器manager，用于把image打包成oci,并且管理容器。
* * container-shim：保证 daemon挂掉，container仍然合约正常运行
* docker daemon:管理 images,network,volume
* restapi:daemon的暴露接口
* docker cli


### OCI: Open Container Initiative
 runtime spec：运行环境规范
 image spec:镜像规范