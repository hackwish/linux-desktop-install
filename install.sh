#!/bin/bash

if [ "$(id -u)" != "0" ]; then
  echo "Este script debe ejecutarse como root (sudo)." >&2
  exit 1
fi

# Bootstraping
#set -e

# install that if we have to.
which lsb_release && apt-get --yes install lsb-release

# Load up the release information
export DISTRIB_CODENAME=`lsb_release -c -s`
# DISTRIB_CODENAME=`lsb_release -c -s`

apt-add-repository universe
apt-add-repository multiverse

if [ ${DISTRIB_CODENAME} == 'bionic' ] || [ ${DISTRIB_CODENAME} == 'disco' ] || [ ${DISTRIB_CODENAME} == 'eoan' ]; then
	echo "Adding Ansible PPA"
   	apt-add-repository --yes ppa:ansible/ansible
else
	echo "NOT Adding Ansible PPA"	
	echo $DISTRIB_CODENAME
fi


echo "Actualizando el sistema..."
apt-get update && apt-get -y --force-yes upgrade && apt-get -y --force-yes dist-upgrade

echo "Instalando dependencias previas"
apt-get install -y curl \
		wget \
		rsync \
		git \
		software-properties-common \
		apt-transport-https

DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" ansible

# Fix Ubuntu codenames for based distros
echo "CodeName ANTES: $DISTRIB_CODENAME"

if [ ${DISTRIB_CODENAME} == 'ulyana' ]; then
	echo $DISTRIB_CODENAME
	export DISTRIB_CODENAME='focal'
elif [ ${DISTRIB_CODENAME} == 'tricia' ]; then
	export DISTRIB_CODENAME='bionic'
else
	export DISTRIB_CODENAME=`lsb_release -c -s`
fi

echo "CodeName AHORA: $DISTRIB_CODENAME"

#Ansible
echo "Iniciando Ansible Deploy"
ANSIBLE_CUSTOM_DIR=`pwd`

echo "Descargando requirements"
ansible-galaxy install --force -r ${ANSIBLE_CUSTOM_DIR}/ansible/requirements.yml

echo "Comienza Deployment con Ansible"
ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/desktop.yml

echo "TODO LISTO!!"
