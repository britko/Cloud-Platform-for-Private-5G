#!/bin/bash

# namespace 생성
kubectl create ns monitoring

## prometheus directory
kubectl create -f /home/master/kubernetes/prometheus/YAML/prometheus/prometheus-cm.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/prometheus/prometheus-crb.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/prometheus/prometheus-cr.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/prometheus/prometheus-deployment.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/prometheus/prometheus-svc.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/prometheus/prometheus-node-exporter.yaml

## kube-state directory
kubectl create -f /home/master/kubernetes/prometheus/YAML/kube-state/kube-state-crb.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/kube-state/kube-state-cr.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/kube-state/kube-state-sa.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/kube-state/kube-state-deployment.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/kube-state/kube-state-svc.yaml

## grafana directory
kubectl create -f /home/master/kubernetes/prometheus/YAML/grafana/grafana-deployment.yaml
kubectl create -f /home/master/kubernetes/prometheus/YAML/grafana/grafana-svc.yaml