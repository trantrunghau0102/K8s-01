#!/bin/bash

sudo yum update -y
curl -fsSL https://get.docker.com/ | sh
sudo systemctl enable docker.service
sudo systemctl start docker
sudo usermod -aG docker vagrant

cat >> /etc/hosts <<EOF
192.168.10.11 master1
192.168.10.12 worker1
192.168.10.13 worker2
EOF

cd ~
mkdir kubernetes_installation/

cd /home/vagrant/kubernetes_installation
git clone https://github.com/kubernetes-sigs/kubespray.git --branch release-2.16

cd /home/vagrant/kubernetes_installation/kubespray
cp -rf inventory/sample inventory/hautt-cluster

cd /home/vagrant/kubernetes_installation/kubespray/
cd inventory/hautt-cluster
cat >> hosts.yaml << EOF
[all]
master1  ansible_host=192.168.10.11      ip=192.168.10.11
worker1  ansible_host=192.168.10.12      ip=192.168.10.12
worker2  ansible_host=192.168.10.13      ip=192.168.10.13

[kube-master]
master1

[kube-node]
worker1
worker2

[etcd]
master1

[k8s-cluster:children]
kube-node
kube-master

[calico-rr]

[vault]
master1
worker1
worker2
EOF

cd /home/vagrant/kubernetes_installation/kubespray/
sed -i "/kube_network_plugin:/c\kube_network_plugin: flannel" inventory/hautt-cluster/group_vars/k8s_cluster/k8s-cluster.yml

