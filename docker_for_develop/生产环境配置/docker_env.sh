mkdir -p /etc/docker
cp daemon.json /etc/docker
mkdir -p /home/hack520/docker


systemctl enable docker
systemctl start docker
