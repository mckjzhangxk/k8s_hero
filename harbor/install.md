```sh
wget -y https://github.com/goharbor/harbor/releases/download/v2.7.3/harbor-online-installer-v2.7.3.tgz
tar -xvf harbor-online-installer-v2.7.3.tgz

cd harbor
vi harbor.yml
./install.sh
```
harbor默认的密码是 admin/Harbor12345