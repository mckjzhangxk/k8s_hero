#！/bin/bash
docker pull $1 --platform amd64
docker tag  $1 "harbor.baijiayun.com/sidecar/$2"
docker push "harbor.baijiayun.com/sidecar/$2"