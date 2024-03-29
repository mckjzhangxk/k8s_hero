
PubIp=""
MS_TAG=""
function getIpFromCip(){
    echo "GetPubIp Request"
    echo "================>"
    PubIp=$(curl -s cip.cc|head -n 1|tr -d " "|cut -d : -f 2)
    echo "GetPubIp Response"
    echo "<================"

}

function labelNode(){
    PubIp=$1
    data="
    {
       \"metadata\": {
            \"labels\": {
            \"pubIp\":\"$PubIp\",
            \"pubId\":null
            }
        }
    }
   "

    echo "LabelNode Request"
    echo "================>"
    echo "api-server=$KUBERNETES_SERVICE_HOST\n"
    echo "node=$NodeName\n"
    echo "token=$TOKEN\n"
    echo "data="
    echo "$data"|jq "."

    result=$(curl -s --insecure --request PATCH "$KUBERNETES_SERVICE_HOST/api/v1/nodes/$NodeName" \
    --header "Authorization: Bearer $TOKEN" \
    --header "Content-Type: application/merge-patch+json" \
    --data-raw "$data" |jq '.metadata.labels')


    echo "LabelNode Response"
    echo "<================"
    echo $result|jq "."
}


function getIpFromNodeLabel(){

    echo 'begin Fetch PubIp================>'
    echo api-server=$KUBERNETES_SERVICE_HOST
    echo node=$NodeName
    echo token=$TOKEN
    PubIp=$(curl -s -X GET https://$KUBERNETES_SERVICE_HOST:443/api/v1/nodes/$NodeName --header "Authorization: Bearer $TOKEN" --insecure \
    |jq '.metadata.labels.pubIp')
    echo "================>"
}

function getTagFromNodeLabel(){
    echo 'begin Fetch MS_TAG================>'
    echo api-server=$KUBERNETES_SERVICE_HOST
    echo node=$NodeName
    echo token=$TOKEN
    MS_TAG=$(curl -s -X GET https://$KUBERNETES_SERVICE_HOST:443/api/v1/nodes/$NodeName --header "Authorization: Bearer $TOKEN" --insecure \
    |jq '.metadata.labels.msTag')
    echo "================>"
}
# 自动获取token
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
case $Chioce in
        1) #公网地址获取
            getIpFromCip
            echo $PubIp
            echo $PubIp >> /root/externalIp/pubIp
            getTagFromNodeLabel
            echo $MS_TAG
            echo $MS_TAG >> /root/externalIp/msTag
            cp /root/startup.sh /root/externalIp
        ;;
        2) #给节点打标签
             getIpFromCip
             labelNode $PubIp
             sleep 2592000
        ;;
        3)
             getIpFromNodeLabel
             echo  $PubIp
             echo $PubIp >> /root/externalIp/pubIp
             getTagFromNodeLabel
             echo $MS_TAG
             echo $MS_TAG >> /root/externalIp/msTag
             cp /root/startup.sh /root/externalIp
        ;;
        *)
        continue
        ;;
esac

# getIpFromCip 
# echo $PubIp

# labelNode $PubIp

# getIpFromNodeLabel

# echo $PubIp