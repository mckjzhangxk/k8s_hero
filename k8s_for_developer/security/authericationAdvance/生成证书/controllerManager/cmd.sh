openssl genrsa -out controller.key 2048
openssl req -new -key controller.key -subj "/CN=KUBE-CONTOLLER-MANAGER" -out controller.csr
openssl x509 -req -in controller.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out  controller.crt