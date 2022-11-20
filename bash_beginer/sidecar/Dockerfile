FROM busybox

WORKDIR /root
COPY ./get_pubIp.sh /root
COPY ./jq-linux64 /bin/jq
COPY ./curl-amd64 /bin/curl

ENTRYPOINT ["/bin/sh","-c","'/root/get_pubIp.sh'"]

# docker run --rm --name abc1 --env NodeName=node1  imagename