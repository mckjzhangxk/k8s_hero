swapoff -a

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system


#docker install
apt-get update

apt-get install -y \
    unzip \
    ca-certificates \
    curl \
    gnupg \
    lsb-release


mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 设置cgroup=systemd
cat <<EOF > /etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
systemctl daemon-reload
systemctl restart docker

#containerd install 
# curl  http://47.94.138.138:8011/cni-plugins-linux-amd64-v1.1.1.tgz -o cni-plugins-linux-amd64-v1.1.1.tgz
# curl  http://47.94.138.138:8011/containerd-1.6.14-linux-amd64.tar.gz -o containerd-1.6.14-linux-amd64.tar.gz
# curl  http://47.94.138.138:8011/runc.amd64 -o runc.amd64
# curl  http://47.94.138.138:8011/containerd.service -o containerd.service
# kubeadam kubelet kubectl
apt-get update
apt-get install -y apt-transport-https ca-certificates curl

curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg http://47.94.138.138:8011/apt-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] http://mirrors.ustc.edu.cn/kubernetes/apt kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


apt-get update
apt-get install -y kubeadm=1.22.0-00 kubelet=1.22.0-00 kubectl=1.22.0-00
apt-mark hold kubelet kubeadm kubectl


wget https://golang.google.cn/dl/go1.18.5.linux-amd64.tar.gz
tar xfz go1.18.5.linux-amd64.tar.gz -C /usr/local

curl http://47.94.138.138:8011/cri-dockerd-master.zip -o cri-dockerd.zip
unzip cri-dockerd.zip

mkdir -p cri-dockerd-master/bin
cd cri-dockerd-master && /usr/local/go/bin/go build -o bin/cri-dockerd
mkdir -p /usr/local/bin
install -o root -g root -m 0755 cri-dockerd-master/bin/cri-dockerd /usr/local/bin/cri-dockerd
cp -a cri-dockerd-master/packaging/systemd/* /etc/systemd/system
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket


# 安装pod网络
# kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml