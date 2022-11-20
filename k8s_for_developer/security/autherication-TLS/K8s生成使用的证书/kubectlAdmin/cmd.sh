openssl genrsa -out admin.key 2048
openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr
openssl x509 -req -in admin.csr -CA ../idc-pki/ca.crt -CAkey ../idc-pki/ca.key -CAcreateserial -out  admin.crt