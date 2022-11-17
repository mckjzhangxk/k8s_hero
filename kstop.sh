echo "shutdown now ....."
kubectl scale deploy -n vloud  vloudadmin --replicas=0
sleep 2
kubectl scale deploy -n vloud  master --replicas=0
sleep 2
kubectl scale deploy -n vloud  authorization --replicas=0
sleep 2
kubectl scale deploy -n vloud  center --replicas=0
sleep 2
kubectl scale deploy -n vloud  vloudapi --replicas=0
sleep 2
kubectl scale deploy -n vloud  roomproxy --replicas=0
sleep 2
kubectl scale deploy -n vloud  roomserver --replicas=0
sleep 2


kubectl scale deploy -n vloud vlouddemo --replicas=0
sleep 2
kubectl scale deploy -n vloud  router --replicas=0
sleep 2
kubectl scale deploy -n vloud  tree --replicas=0
sleep 2
kubectl scale deploy -n fundamental msms --replicas=0
sleep 2
kubectl scale deploy -n vloud  dispatcher --replicas=0
sleep 2
kubectl scale deploy -n vloud  bridge --replicas=0
sleep 2

kubectl scale deploy -n vloud  collector --replicas=0
sleep 2
kubectl scale deploy -n vloud  repository --replicas=0
sleep 2
kubectl scale deploy -n vloud  channel --replicas=0
sleep 2
kubectl scale deploy -n vloud  notifycenter --replicas=0
sleep 2
kubectl scale deploy -n vloud  mixerserver --replicas=0

echo "finish shutdown"