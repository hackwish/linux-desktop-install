#!/bin/bash

if [ "$(id -u)" != "0" ]; then
  echo "Este script debe ejecutarse como root (sudo)." >&2
  exit 1
fi

# Bootstraping
set -e

# # install that if we have to.
# which lsb_release || apt-get --yes install lsb-release

# # Load up the release information
# DISTRIB_CODENAME=`lsb_release -c -s`

apt-add-repository universe
apt-add-repository multiverse


echo "Actualizando el sistema..."
apt-get update && apt-get -y upgrade

echo "Instalando dependencias previas"
apt-get install -y curl \
		wget \
		rsync \
		git \
		software-properties-common \
		apt-transport-https \
		python2-minimal

#Ansible
echo "Instalando Ansible"
#wget http://mirrors.kernel.org/ubuntu/pool/universe/p/paramiko/python-paramiko_2.6.0-1_all.deb
#dpkg -i python-paramiko_2.6.0-1_all.deb

alias pip='pip3'
alias python='python3'

#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#python get-pip.py
#pip install ansible

# apt-add-repository --yes ppa:ansible/ansible

#touch /etc/apt/sources.list.d/ansible-ubuntu-ansible-eoan.list
#echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu eoan main" >> /etc/apt/sources.list.d/ansible-ubuntu-ansible-eoan.list
# echo "deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu eoan main" >> /etc/apt/sources.list.d/ansible-ubuntu-ansible-eoan.list

#apt-get update

DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" ansible

echo "Iniciando Ansible Deploy"
ANSIBLE_CUSTOM_DIR=`pwd`

echo "Descargando requirements"
ansible-galaxy install --force -r ${ANSIBLE_CUSTOM_DIR}/ansible/requirements.yml

echo "Comienza Deployment con Ansible"
ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/desktop.yml

echo "TODO LISTO!!"
