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

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin


# kubeadam kubelet kubectl
apt-get update
apt-get install -y apt-transport-https ca-certificates curl

curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg http://47.94.138.138:8011/apt-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] http://mirrors.ustc.edu.cn/kubernetes/apt kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


apt-get update
apt-get install -y kubeadm=1.21.0-00 kubelet=1.21.0-00 kubectl=1.21.0-0
apt-mark hold kubelet kubeadm kubectl


wget https://golang.google.cn/dl/go1.18.5.linux-amd64.tar.gz
tar xfz go1.18.5.linux-amd64.tar.gz -C /usr/local

curl http://47.94.138.138:8011/cri-dockerd-master.zip -o cri-dockerd.zip
unzip cri-dockerd.zip

cd cri-dockerd
mkdir bin
go build -o bin/cri-dockerd
mkdir -p /usr/local/bin
install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
cp -a packaging/systemd/* /etc/systemd/system
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket