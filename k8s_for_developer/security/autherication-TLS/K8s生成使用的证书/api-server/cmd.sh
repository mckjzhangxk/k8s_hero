servername=api-server
openssl genrsa -out $servername.key 2048  
openssl req -new -key $servername.key -subj "/CN=KUBE-API-SERVER" -out $servername.csr -config openssl.cnf
openssl x509 -req -in $servername.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out  $servername.crt