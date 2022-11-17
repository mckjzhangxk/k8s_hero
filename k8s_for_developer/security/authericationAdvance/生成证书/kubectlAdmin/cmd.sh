openssl genrsa -out admin.key 2048
openssl req -new -key admin.key -subj "/CN=kube-admin/OU=system:masters" -out admin.csr
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out  admin.crt