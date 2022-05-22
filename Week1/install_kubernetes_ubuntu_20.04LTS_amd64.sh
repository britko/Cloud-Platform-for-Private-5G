#!/bin/bash

echo "Start Kubernetes installing..."

# Install Docker(https://docs.docker.com/engine/install/ubuntu/)
sudo apt-get install -y\
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

# Disable Swap Memory
sudo swapoff -a && sudo sed -i "/ swap / s/^/#/" /etc/fstab

# Enable br_netfilter Mode
sudo modprobe br_netfilter

# Configuration iptables
sudo cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

# Install Kubenetes
sudo apt-get update && sudo apt-get install -y apt-transport-https curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl

# Configuration Cgroup Driver
sed -i "13s/-H/--exec-opt native.cgroupdriver=systemd -H/" /usr/lib/systemd/system/docker.service

sudo systemctl daemon-reload

sudo systemctl restart docker

sudo docker info | grep -i cgroup

echo "Installed Docker, Kubernetes(kubelet, kubeadm, kubectl) & Environment configure Complete!!!"