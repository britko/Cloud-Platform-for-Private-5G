#!/bin/bash

# Init kubeadm
sudo kubeadm init \
--pod-network-cidr=172.16.0.0/16

# make config file
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "./kube/config make..."

# Install CNI (Conrtol-plane)
curl https://docs.projectcalico.org/manifests/calico.yaml -O
kubectl apply -f calico.yaml

echo "Master Node Configure complete!"