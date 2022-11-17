docker container stats   //查看允许的容器
docker container $id inspect  //查看允许的容器 的json 配置
docker container $id top //查看允许的容器【进程】

docker system events --since 60m //1小时以内， 所以的docker事件
docker system events  --filter 'container=webapp'



================================================================
docker container pause $id
docker container unpause $id   //使用linux 的cgroup freezer,确保发送信号不被catch

docker container kill -s 9  $id

//删除
docker container prune //清除所以stop的容器
docker image prune

--rm标准

docker run --rm nginx //如果容器stop，它会被【自动清除】