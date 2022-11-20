openssl genrsa -out etcd.key 2048
openssl req -new -key etcd.key -subj "/CN=etcd" -out etcd.csr
openssl x509 -req -in etcd.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out  etcd.crt


for v in {1..2}
do
    filename=etcd-peer${v}
    openssl genrsa -out $filename.key 2048
    openssl req -new -key $filename.key -subj "/CN=etcd-peer-$v" -out $filename.csr
    openssl x509 -req -in $filename.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out  $filename.crt

done

rm *.csr