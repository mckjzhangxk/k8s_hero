export PUB_IPS=$(cat /var/lib/externalIp/pubIp)
echo "Get PublicIp from Environment:" $PUB_IPS
export PUB_IP=$PUB_IPS
export MS_TAGS=$(cat /var/lib/externalIp/msTag)
echo "Get MS_TAG from Environment:" $MS_TAGS
export MS_TAG=$MS_TAGS
cd /root/msms
node ./restful/dist/index.js
