

#生成服务端证书
for v in {1..2}
do
    nodeName=node${v}
    openssl genrsa -out $nodeName.key 2048
    openssl req -new -key $nodeName.key -subj "/CN=$nodeName" -out $nodeName.csr
    openssl x509 -req -in $nodeName.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out  $nodeName.crt
done


#生成客户端证书,用于访问apiserver
# N:system:node:$Nodename
# O:system:nodes

for v in {1..2}
do
    fileName=node${v}-client
    nodeName=node${v}

   openssl genrsa -out $fileName.key 2048
   openssl req -new -key $fileName.key -subj "/CN=system:node:$nodeNam/O=system:nodes" -out $fileName.csr
   openssl x509 -req -in $fileName.csr -CA ../CA/ca.crt -CAkey ../CA/ca.key -CAcreateserial -out  $fileName.crt
done



rm *.csr