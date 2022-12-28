安装containerd
```
tar Cxzvf /usr/local containerd-1.6.2-linux-amd64.tar.gz

cp containerd.service /usr/local/lib/systemd/system/containerd.service

systemctl daemon-reload
systemctl enable --now containerd
```

安然runc
```
install -m 755 runc.amd64 /usr/local/sbin/runc
```

CNI plugin 
```
$ mkdir -p /opt/cni/bin
$ tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
```