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

echo "Vamos a verificar si tiene Ansible y la distribución que usas..."
echo "Instalaremos Ansible mediante pip para obtener la versión más reciente disponible en Linux."

if command -v apt-get >/dev/null 2>&1; then
    if dpkg -s ansible >/dev/null 2>&1; then
        echo "Se encontró una instalación previa de Ansible desde apt; se eliminará para priorizar la versión más reciente."
        DEBIAN_FRONTEND=noninteractive apt-get remove -y ansible ansible-core >/dev/null 2>&1 || true
    fi
fi

echo "Actualizando el sistema..."
apt-get update && apt-get -y --force-yes upgrade

echo "Instalando y configurando Flatpak..."
if ! command -v flatpak &> /dev/null; then
    apt-get install --no-install-recommends -y flatpak
fi
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true
flatpak update -y

echo "Instalando y configurando Snap..."
if ! command -v snap &> /dev/null; then
    apt-get install --no-install-recommends -y snapd
fi
rm -f /etc/apt/preferences.d/nosnap.pref
snap refresh || true

echo "Instalando dependencias previas"
apt-get install --no-install-recommends -y curl wget rsync git fontconfig software-properties-common apt-transport-https ca-certificates gnupg2 openssh-server ubuntu-keyring python3 python3-pip python3-openssl python3-wheel python3-jinja2 python3-setuptools python-is-python3

echo "Tu arquitectura es ${ARCHITECTURE}"

if [ ${ARCHITECTURE} == 'aarch64' ] || [ ${ARCHITECTURE} == 'armv7l' ]; then
	echo "Quitemos lo innecesario..."
	apt-get remove --purge -y triggerhappy anacron logrotate dphys-swapfile xserver-common lightdm
	systemctl disable x11-common
	systemctl disable bootlogs
	systemctl disable console-setup
	apt-get install -y busybox-syslogd python3-pip
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

echo "Instalando la última versión de Ansible para Linux..."
if ! command -v python3 >/dev/null 2>&1; then
    echo "Python 3 no está disponible; instalando dependencias básicas..."
    apt-get install --no-install-recommends -y python3 python3-pip python3-venv python3-full
else
    apt-get install --no-install-recommends -y python3-pip python3-venv python3-full
fi

ANSIBLE_VENV_DIR="/opt/ansible-venv"
python3 -m venv "$ANSIBLE_VENV_DIR"
"$ANSIBLE_VENV_DIR/bin/pip" install --upgrade pip setuptools wheel
"$ANSIBLE_VENV_DIR/bin/pip" install --upgrade ansible-core

ln -sf "$ANSIBLE_VENV_DIR/bin/ansible" /usr/local/bin/ansible
ln -sf "$ANSIBLE_VENV_DIR/bin/ansible-playbook" /usr/local/bin/ansible-playbook
ln -sf "$ANSIBLE_VENV_DIR/bin/ansible-galaxy" /usr/local/bin/ansible-galaxy
export PATH="/usr/local/bin:$PATH"

ansible --version | head -n 5

echo "Ahora vamos a adecuar la instalación..."

# Fix Ubuntu codenames for based distros
echo "CodeName ANTES: $DISTRIB_CODENAME"
# Linux Mint distros
if [ ${DISTRIB_CODENAME} == 'wilma' ] || [ ${DISTRIB_CODENAME} == 'xia' ] || [ ${DISTRIB_CODENAME} == 'zara' ] || [ ${DISTRIB_CODENAME} == 'zena' ]; then
        echo $DISTRIB_CODENAME
        export DISTRIB_CODENAME='noble'
elif [ ${DISTRIB_CODENAME} == 'vanessa' ] || [ ${DISTRIB_CODENAME} == 'vera' ] || [ ${DISTRIB_CODENAME} == 'victoria' ] || [ ${DISTRIB_CODENAME} == 'virginia' ]; then
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

echo "CodeName AHORA: $DISTRIB_CODENAME"

# Mouse Pointer theme in root, Qt and Flatpak applications
update-alternatives --auto x-cursor-theme

#Ansible
echo "Iniciando Ansible Deploy"
ANSIBLE_CUSTOM_DIR=`pwd`

echo "Descargando Roles y Colecciones"
ansible-galaxy role install --force -r ${ANSIBLE_CUSTOM_DIR}/ansible/requirements.yml

echo "instalando colecciones"
ansible-galaxy collection install --force -r ${ANSIBLE_CUSTOM_DIR}/ansible/requirements.yml


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
