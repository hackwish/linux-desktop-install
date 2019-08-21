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

echo "Instalando dependencias previas"
apt-get install -y curl \
		wget \
		rsync \
		git \
		software-properties-common \
		apt-transport-https

apt-add-repository --yes ppa:ansible/ansible

echo "Actualizando el sistema..."
apt-get update # && apt-get -y --force-yes upgrade && apt-get -y --force-yes dist-upgrade

DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" ansible

#Ansible
echo "Iniciando Ansible Deploy"
ANSIBLE_CUSTOM_DIR=`pwd`

echo "Descargando requirements"
ansible-galaxy install -r ${ANSIBLE_CUSTOM_DIR}/ansible/requirements.yml

echo "Comienza Deployment con Ansible"
ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/desktop.yml

echo "TODO LISTO!!"
