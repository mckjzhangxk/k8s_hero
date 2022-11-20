P160
参考文档：https://docs.releng.linuxfoundation.org/en/latest/gpg.html
https://www.linuxjournal.com/content/flat-file-encryption-openssl-and-gpg
helm package ./foo-chart

gpg 1.0
```
安装：   yum install gunpg
        apt install gunpg
        brew install gpg
老版格式  gpg
新版格式v2：kbx

版本的转换(helm需要老的版本)
    gpg --export-secret-keys >./gpg-keys/secring.gpg //转换私钥！
    gpg --export 'baijiayun' >./gpg-keys/publickey //转换公钥！
生成密钥对：
    gpg -gen-key // 保存到/root/.gnupg/trustdb.gpg文件加密
    gpg --quick-generate-key $USER-ID //2.3.8版本的命令
    gpg --full-generate-key  $USER-ID //2.3.8版本的命令
显示本机所有创建的key
    gpg --list-keys 
    gpg --list-secret-keys //显示私钥

从远处server导入key
    gpg --recv-keys --keyserver keyserver.ubuntu.com 8D40FE0CACC3FED4AD1C217180BA57AAFAAD1CA5
```

helm 打包1.0

```
无签名打包：
    helm package ./foo-chart 
签名打包
    helm package --sign --key 'baijiayun'  --keyring ./gpg-keys/secring.gpg ./foo-chart
    //--sign 签名foo-chart
    //--key 私钥的名字
    //--keyring 私钥v1格式,secring.gpg是 转换后的私钥

    >生成 foo-chart.tgz.prov文件
    >sha256sum foo-chart.tgz //验证foo-chart.tgz.prov 摘要hash
验证签名：
     helm verify --keyring ./gpg-keys/publickey ./foo-chart-0.1.0.tgz

     >> Using Key With Fingerprint: 54A1D6A3D6AECBB4AEC142B34257BA5AE9D5EE8A
     Fingerprint可以用于发布？？？
```

实际操作中
```
//先导入验证的pubkey
gpg --recv-keys --keyserver keyserver.ubuntu.com 8D40FE0CACC3FED4AD1C217180BA57AAFAAD1CA5
//然后按照验证
helm install --verify foo-chart-0.1.0

```