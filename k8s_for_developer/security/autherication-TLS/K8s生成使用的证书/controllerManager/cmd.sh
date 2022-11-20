openssl genrsa -out controller.key 2048
openssl req -new -key controller.key -subj "/CN=SYSTEM:KUBE-CONTOLLER-MANAGER" -out controller.csr
openssl x509 -req -in controller.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out  controller.crt