## 准备
```sh
#关闭防火墙
systemctl stop firewalld
systemctl disable firewalld

#关闭selinux,强制访问策略安全控制
vi /etc/sysconfig/selinux  
#SELINUX=disabled
reboot
getenforce
```

## 软件包安装
```sh
yum install -y curl policycoreutils openssh-server openssh-client perl
yum install postfix

#邮件服务
systemctl enable postfix
systemctl start postfix

#安装社区版
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
yum install -y gitlab-ce
```

## 生成证书
```sh
mkdir -p /etc/gitlab/ssl
cd /etc/gitlab/ssl
#生成私钥
openssl genrsa -out "/etc/gitlab/ssl/gitlab.axjz.com.key" 2048  
#生成证书请求 -new 表示新的请求 -key  私钥,common name 输入域名
openssl req -new -key "/etc/gitlab/ssl/gitlab.axjz.com.key"  -out "/etc/gitlab/ssl/gitlab.axjz.com.csr"
#创建证书
openssl x509 -days 364 -req -in  "/etc/gitlab/ssl/gitlab.axjz.com.csr"  -signkey "/etc/gitlab/ssl/gitlab.axjz.com.key" -out  "/etc/gitlab/ssl/gitlab.axjz.com.crt"
#转换成pem格式
openssl dhparam -out "/etc/gitlab/ssl/dhparam.pem" 2048

chmod 600 *
```

## 更改配置
```sh
vi /etc/gitlab/gitlab.rb

# 修改 external_url，协议改成https，域名改成证书签名的域名

#nginx['redirect_http_to_https']设置成true

#更改 ssl_certificate,ssl_certificate_key
#更改 ssl_dhparam

gitlab-ctl reconfigure
```

```sh
配置nginx,重定向http
vi /var/opt/gitlab/nginx/conf/gitlab-http.conf
# server_name下面加入,注意是80的这个server
rewrite ^(.*)$ https://$host$1 permanent;

#重启生效
gitlab-ctl restart
```

## 访问gitlab
```sh
#查看初始化密码 
cat /etc/gitlab/initial_root_password
#浏览器访问 https://gitlab.axjz.com/
```

## 提交文件前准备
```
    git config --global user.name "Your Name"
    git config --global user.email you@example.com

    git -c http.sslVerify=false clone $url
```