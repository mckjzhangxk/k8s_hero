P38页

https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/07-Security/05-TLS-Basics.md

### TakeAway From this Lecture

* 服务器证书（credential）：证明服务器办法公钥的合法性 凭证
* <font color=red>CA证书：(公钥,私钥) 私钥用于 签名CSR，公钥用于验证 签名的证书</font>
* 客户端证书（credential）：证明 客户端 是经过 服务端 信任的CA 认证过的。
* 对称秘钥： 由通信的一方生成，经过cert传输交换，加密应用数据。

### 1.生成web服务器证书的方法
    openssl genrsa -out my-bank.key 1024 #prK
    openssl rsa -in my-bank.key -pubout > my-bank.pem #pubK
    
```
注意，顺序是 先生存私匙，再生成公钥,以上的操作主要针对的是 系统的ssh管理员。
```
### 2.证书(certificate)： 用于证明 pubkey 是subject的公钥！

证书的主要组成部分：
- subject 颁发的域名
- subject alternative name 如果有多域名，罗列于此
- public key
- **Issuer:办法证书的机构**
- Validity:有效期起止
- **证书也叫做 Credentials!**
## 3.证书的合法性如何保证？ quick answer:验证签名与颁发人！！


    1.谁是签发人：CA certificate authority,权威机构的签名证书具有 【证明性】。
    2.如何签名
        2.1 你把你的【请求签名文件】发送给CA（生成CSR文件，certificate signing request）
        
```
openssl req -new -key my-bank.key -out my-bank.csr -subj"/C=US/ST=CA/O=myorg,Inc./CN=mybank.com"            
```
        2.2 CA 在线审核确认后，给你签名，
        2.3 最后把签名的证书CERT发送给你，你部署到web server上！
    3. 谁来验证ca的签名的不被篡改？ quick answer : 信任的CA的公钥

        每个ca 有一对(pubkey,privatekey)
        A privatekey用于ca 签名
        B.pubkey在你浏览器的trusted名单内
        C.你用CA pubkey 验证签名的 合法性！


### 秘钥的总结

+ 管理员：pubk,priK，ssh登录服务器。
    * pubk 在ssh 服务器上“上锁”。
    * priK 在管理员机器上，”开锁“

* webserver:cert,priK,用于交换symetric key.
    * cert(pubK)给浏览器用户
    * priK留在server上

+ CA:pubk,priK,签名与校验证书的权威性。
   * priK CA用来签名csr.
   * pubk 浏览器校验 签名是 CA这个办法机构 签发的。
* 浏览器用户：symetric key,加密app data

#### 术语总结
PKI:public key infrastructure:

    CA,Server,用户，已经维护digital sign的过程叫做 PKI(public key infrastructure)


#### 重要的三个命令
 
生成private key
```
    openssl genrsa -out my-bank.key 1024 
```
 
 根据privatekey 生成public key
 ```
    openssl rsa -in my-bank.key -pubout > my-bank.pem  
 ```

根据privatekey 生成csr(证书签名请求)
```
    openssl req -new -key my-bank.key -out my-bank.csr -subj "/C=US/ST=CA/O=myorg,Inc./CN=mybank.com" 
```


CA 给csr签发证书???
```
    openssl 
```