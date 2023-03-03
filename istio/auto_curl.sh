INGRESS_HOST=k8s-idc-mpc.baijiayun.com
INGRESS_PORT=28264
while true
do
  sleep 0.01
  curl -sS "http://$INGRESS_HOST:$INGRESS_PORT/productpage"
done



while true
do
  echo "xx" >/dev/null
done