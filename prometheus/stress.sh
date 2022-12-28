# INGRESS_HOST=k8s-idc-mpc.baijiayun.com
# INGRESS_PORT=28264
while true
do
  # sleep 0.01
  curl -sS "https://k8s-master-test.baijiayun.com/health"
done

