echo "starting now ....."
kubectl scale deploy -n vloud  vloudadmin --replicas=1
sleep 2
kubectl scale deploy -n vloud  master --replicas=1
sleep 2
kubectl scale deploy -n vloud  authorization --replicas=1
sleep 2
kubectl scale deploy -n vloud  center --replicas=1
sleep 2
kubectl scale deploy -n vloud  vloudapi --replicas=1
sleep 2
kubectl scale deploy -n vloud  roomproxy --replicas=1
sleep 2
kubectl scale deploy -n vloud  roomserver --replicas=1
sleep 2


kubectl scale deploy -n vloud vlouddemo --replicas=1
sleep 2
kubectl scale deploy -n vloud  router --replicas=1
sleep 2
kubectl scale deploy -n vloud  tree --replicas=1
sleep 2
kubectl scale deploy -n fundamental msms --replicas=1
sleep 2
kubectl scale deploy -n vloud  dispatcher --replicas=1
sleep 2
kubectl scale deploy -n vloud  bridge --replicas=1
sleep 2

kubectl scale deploy -n vloud  collector --replicas=1
sleep 2
kubectl scale deploy -n vloud  repository --replicas=1
sleep 2
kubectl scale deploy -n vloud  channel --replicas=1
sleep 2
kubectl scale deploy -n vloud  notifycenter --replicas=1
sleep 2
kubectl scale deploy -n vloud  mixerserver --replicas=1

echo "finish"