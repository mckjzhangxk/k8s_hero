

APISERVER='https://10.16.31.251:6443'
TOKEN='eyJhbGciOiJSUzI1NiIsImtpZCI6Ik9WUWNtSGw4RG5GOVFURkVLZXJ3anh1U2o0MEVLY0x3eGo2UUw0QnR1WlEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlc3BoZXJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrdWJlc3BoZXJlLXRva2VuLWs3Y3NiIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6Imt1YmVzcGhlcmUiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJhYzMwNmYyNy05YmMyLTRhYzEtYTgyNi05OTMyNGI5OTQ4ZjEiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXNwaGVyZS1zeXN0ZW06a3ViZXNwaGVyZSJ9.hoaIkwAsAlVpSDsas8ltHR4DzGwXrmu0YFUepWJo9ERAHNOKFP9p3nAlgqUeIYtKqlGRl3t6UHZjofH8bLvkug-LKqPbO7AGXzO44FiqSCdkZkoXqkPf5FeWui1axSGUPa68enuMBQRZbw6Q4vrURiGxiv80Ruy13LFmfQcHNxPr5lhea63gvbsUz1TpoH16vO2i7etYK7hr0e1t-sGdHbreVMOd9Gz4Kar62s7t-Pn9NmQo1W-t1b4e39OyIEuDnnt1gJglcvHSj9y0YMFy-mZmKjSql4ZUg2bt9WRJckzlRxuopMBMAlOruo3gp_WrIcYvgYXEfOL97TdbUZK6Tw'
NodeName='bjy-idc-brtc-laliu-test0209'
echo 'begin Fetch PubIp'
echo "================>"
echo api-server=$APISERVER
echo node=$NodeName
echo token=$TOKEN
pubIp=$(curl -s -X GET $APISERVER/api/v1/nodes/$NodeName --header "Authorization: Bearer $TOKEN" --insecure \
|jq '.metadata.labels.pubIp')

echo "================>"
echo $pubIp >> /root/externalIp
echo $pubIp
