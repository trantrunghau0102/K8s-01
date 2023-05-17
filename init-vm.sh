#!/bin/bash

sudo swapoff -a
sudo sed '/centos-swap/d' /etc/fstab
sudo yum install git -y
git clone https://github.com/rockman88v/kubernetes_basic_course.git
cp kubernetes_basic_course/session02-Installation/scripts/* .
sudo chmod +x update-vm.sh
sudo chmod +x configure-vm.sh
sudo sed -i '6 s/$/\ -y/g' configure-vm.sh
./configure-vm.sh y