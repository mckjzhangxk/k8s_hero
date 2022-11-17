FROM  ubuntu

RUN apt  update -y && apt install -y coturn

RUN echo "TURNSERVER_ENABLED=1" >>/etc/default/coturn

CMD "turnserver"