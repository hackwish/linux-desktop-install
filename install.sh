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

# Ubuntu distros
if [ ${DISTRIB_CODENAME} == 'bionic' ] || [ ${DISTRIB_CODENAME} == 'disco' ] || [ ${DISTRIB_CODENAME} == 'eoan' ]; then
	echo "Adding Ansible PPA"
   	apt-add-repository --yes ppa:ansible/ansible
# Linux Mint distros
elif [ ${DISTRIB_CODENAME} == 'tricia' ] || [ ${DISTRIB_CODENAME} == 'tina' ] || [ ${DISTRIB_CODENAME} == 'tessa' ] || [ ${DISTRIB_CODENAME} == 'tara' ]; then
	echo "Manual adding Ansible PPA"
	echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" >> /etc/apt/sources.list.d/ansible-ubuntu-ansible-bionic.list
# ElementaryOS distros
elif [ ${DISTRIB_CODENAME} == 'hera' ] || [ ${DISTRIB_CODENAME} == 'juno' ]; then
	echo "Manual adding Ansible PPA"
	echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" >> /etc/apt/sources.list.d/ansible-ubuntu-ansible-bionic.list
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
# Linux Mint distros
if [ ${DISTRIB_CODENAME} == 'ulyana' ] || [ ${DISTRIB_CODENAME} == 'ulyssa' ]; then
	echo $DISTRIB_CODENAME
	export DISTRIB_CODENAME='focal'
elif  [ ${DISTRIB_CODENAME} == 'tricia' ] || [ ${DISTRIB_CODENAME} == 'tina' ] || [ ${DISTRIB_CODENAME} == 'tessa' ] || [ ${DISTRIB_CODENAME} == 'tara' ]; then
	echo $DISTRIB_CODENAME
	export DISTRIB_CODENAME='bionic'
# ElementaryOS distros
elif [ ${DISTRIB_CODENAME} == 'odin' ]; then
	echo $DISTRIB_CODENAME
	export DISTRIB_CODENAME='focal'
elif [ ${DISTRIB_CODENAME} == 'hera' ] || [ ${DISTRIB_CODENAME} == 'juno' ]; then
	echo $DISTRIB_CODENAME
	export DISTRIB_CODENAME='bionic'
else
	echo $DISTRIB_CODENAME
	export DISTRIB_CODENAME=`lsb_release -c -s`
fi

# Workaround Linux Mint 20 no Snaps Support
rm -f /etc/apt/preferences.d/nosnap.pref

echo "CodeName AHORA: $DISTRIB_CODENAME"

#Ansible
echo "Iniciando Ansible Deploy"
ANSIBLE_CUSTOM_DIR=`pwd`

echo "Descargando requirements"
ansible-galaxy install --force -r ${ANSIBLE_CUSTOM_DIR}/ansible/requirements.yml

echo "instalando colecciones"
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.docker
ansible-galaxy collection install community.sops
ansible-galaxy collection install community.general

echo "Comienza Deployment con Ansible"
ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/desktop.yml

echo "TODO LISTO!!"
