FROM busybox

WORKDIR /root
COPY ./sidecar.sh /root
COPY ./startup.sh /root
COPY ./jq-linux64 /bin/jq
COPY ./curl-amd64 /bin/curl

ENTRYPOINT ["/bin/sh","-c","'/root/sidecar.sh'"]

# docker run --rm --name abc1 --env NodeName=node1  imagename