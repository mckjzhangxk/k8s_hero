openssl genrsa -out schedular.key 2048
openssl req -new -key schedular.key -subj "/CN=SYSTEM:KUBE-SCHEDULAR" -out schedular.csr
openssl x509 -req -in schedular.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out  schedular.crt