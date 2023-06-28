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
export ARCHITECTURE=`uname -a | awk '{print $13}'`
# DISTRIB_CODENAME=`lsb_release -c -s`

apt-add-repository universe
apt-add-repository multiverse

echo "Vamos a verificar si tiene Ansible y que distribución usas..."

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
apt-get update && apt-get -y --force-yes upgrade

echo "Instalando dependencias previas"
apt-get install --no-install-recommends -y curl wget rsync git software-properties-common apt-transport-https ca-certificates gnupg2 openssh-server ubuntu-keyring python3 python3-pip python3-openssl python3-jinja2 python-is-python3 libwxgtk3.0-gtk3-0v5

echo "Tu arquitectura es ${ARCHITECTURE}"

if [ ${ARCHITECTURE} == 'aarch64' ]; then
	echo "Quitemos lo innecesario..."
	apt-get remove --purge -y triggerhappy anacron logrotate dphys-swapfile xserver-common lightdm
	systemctl disable x11-common
	systemctl disable bootlogs
	systemctl disable console-setup
	apt-get install -y busybox-syslogd
	dpkg --purge rsyslog
	modprobe ip_conntrack
else  
	# Temporal Modprobe fix
	modprobe ip_conntrack
	# Fix WoeUSB
	# wget http://mirrors.kernel.org/ubuntu/pool/universe/w/wxwidgets3.0/libwxgtk3.0-0v5_3.0.4+dfsg-3_amd64.deb
	# dpkg -i libwxgtk*_amd64.deb
	# rm -rf libwxgtk*
fi

DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" ansible

echo "Ahora vamos a adecuar la instalación..."

# Fix Ubuntu codenames for based distros
echo "CodeName ANTES: $DISTRIB_CODENAME"
# Linux Mint distros
if [ ${DISTRIB_CODENAME} == 'vanessa' ] || [ ${DISTRIB_CODENAME} == 'vera' ]; then
        echo $DISTRIB_CODENAME
        export DISTRIB_CODENAME='jammy'
elif [ ${DISTRIB_CODENAME} == 'ulyana' ] || [ ${DISTRIB_CODENAME} == 'ulyssa' ] || [ ${DISTRIB_CODENAME} == 'uma' ] || [ ${DISTRIB_CODENAME} == 'una' ]; then
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
echo "Opciones de Instalación: "

OPCIONES="base desktop devops tv server salir"

PS3="Selecciona una opción: " 

select installer in $OPCIONES;
do
  case $installer in
	base)
		echo "Se inicia la instalación de $installer"
		ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/common.yml
        break
		;;
	desktop)
		echo "Se inicia la instalación de $installer"
		ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/desktop.yml
        break
		;;
	devops)
		echo "Se inicia la instalación de $installer"
		ansible-playbook -vvv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/devops.yml
        break
		;;
	tv)
		echo "Se inicia la instalación de $installer"
		ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/tv.yml
        break
		;;
	server)
		echo "Se inicia la instalación de $installer"
		ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/server.yml
        break
		;;
    salir) 
        break
        ;; 
    *) 
        echo "$REPLY no es una opción válida" 
        ;; 
  esac
done

echo "TODO LISTO!!"
