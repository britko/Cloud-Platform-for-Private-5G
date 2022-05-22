#!/bin/bash

echo "kubeadm reset start.."

sudo kubeadm reset
sudo systemctl restart kubelet
sudo reboot