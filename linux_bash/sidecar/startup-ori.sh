export PUB_IPS=$(cat /var/lib/externalIp/pubIp)
echo "Get PublicIp from Environment:" $PUB_IPS
export PUB_IP=$PUB_IPS
cd /root/msms
node ./restful/dist/index.js
