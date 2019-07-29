# INSTALAR UBUNTU 16.04 - MINT 18 Y DERIVADOS #

## post instalación ##
``sudo apt update``
``sudo apt upgrade``
``sudo apt dist-upgrade``

#ADD REPOS

sudo add-apt-repository ppa:ubuntu-wine/ppa
sudo add-apt-repository ppa:webupd8team/tor-browser
sudo add-apt-repository ppa:numix/ppa
sudo add-apt-repository ppa:system76/pop
sudo add-apt-repository ppa:system76-dev/stable
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:pdoes/gitflow-avh

sudo apt install curl wget

#SYNCTHING
# Add the release PGP keys:
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
# Add the "stable" channel to your APT sources:
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

#DOCKER
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
sudo apt-get update && apt-cache policy docker-engine

#NODEJS
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

#GIT-LFS
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

#Google Cloud SDK
## Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-xenial"

## Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

## Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


1. actualizar
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade

sudo apt install ubuntu-restricted-extras 

sudo apt install linux-headers-$(uname -r) build-essential checkinstall make automake cmake autoconf git git-core libdvd-pkg  intel-microcode synaptic apt-xapian-index gdebi preload file-roller p7zip-full p7zip-rar rar unrar zip unzip unace p7zip-full p7zip-rar sharutils mpack arj brasero-cdrkit k3b vlc browser-plugin-vlc soundconverter  catfish hardinfo gufw ttf-mscorefonts-installer libncurses5-dev build-essential module-assistant lm-sensors hddtemp pepperflashplugin-nonfree icedtea-plugin ttf-mscorefonts-installer ttf-bitstream-vera ttf-dejavu terminator htop dconf-editor fonts-noto lshw nmap curl xclip mailutils postfix meld zsh rar unace p7zip-full p7zip-rar sharutils mpack arj htop atop nmon postfix lshw tcpdump ncdu multitail ccze nano iftop stress snmp snmp-mibs-downloader snmpd pv iotop smartmontools python python-setuptools nmap powertop collectd default-jre default-jdk openssh-server  openssh-client xinetd telnetd git subversion nfs-kernel-server  nfs-common vim vim-common lm-sensors netcat automake autoconf libreadline-dev  libssl-dev libyaml-dev libffi-dev libtool unixodbc-dev  ubuntu-restricted-extras synaptic terminator default-jre default-jdk chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg adobe-flashplugin shutter vim-gnome vim-gtk  vim-gui-common vim-snippets gimp swaks gir1.2-gtop-2.0 gir1.2-networkmanager-1.0  gir1.2-clutter-1.0 nodejs mysql-workbench mysql-workbench-data quodlibet redshift* filezilla* siege libsvn-java openvpn network-manager-openvpn network-manager-openvpn-gnome git-ftp  pgadmin3 rbenv ssh-askpass dia kdeconnect nvidia-cuda-dev nvidia-cuda-toolkit libssl-dev cmake cmake-curses-gui libjansson-dev clang libffi-dev nodejs yarn libgdbm-dev libncurses5-dev automake libtool bison libffi-dev linuxbrew-wrapper libmagic-dev  libjansson-dev clang psensor playonlinux libspice-client-gtk-3.0 software-properties-common gnome-tweak-tool gnome-shell-extensions gir1.2-spice-client-glib-2.0 gir1.2-spice-client-gtk-3.0 python-spice-client-gtk gcc g++ make yarn wine1.8 tor tor-browser numix* sublime-text lxd lxd-client zfs nfs-kernel-server syncthing docker git-lfs zsh python-pip tmux plank snapd apt-transport-https google-cloud-sdk kubectl google-cloud-sdk-app-engine-java google-cloud-sdk-app-engine-python  google-cloud-sdk-pubsub-emulator google-cloud-sdk-bigtable-emulator  google-cloud-sdk-datastore-emulator python-pip libpython-dev git-flow qemu-kvm moreutils jq libxml-writer-perl libguestfs-perl uuid-runtime golang-go

ssh-keygen && fc-cache -fv && sudo sensors-detect && sudo service kmod start && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git config --global color.ui true
git config --global user.email "marcelo.cardenasc@gmail.com"
git config --global user.name "Marcelo Cardenas"

7. Otros paquetes (desde la web - DEB)
#MINIKUBE
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.27.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

#Chrome
https://www.google.com/chrowgetme/browser/desktop/index.html

#Teamviewer
https://www.teamviewer.com/es/download/linux.aspx

#Dropbox
https://www.dropbox.com/install?os=lnx

#MEGA
https://mega.nz/#sync!linux

#Oracle Virtualbox
https://www.virtualbox.org/wiki/Linux_Downloads

#Vagrant
https://www.vagrantup.com/downloads.html

#Packer
wget https://releases.hashicorp.com/packer/0.3.1/packer_1.3.1_linux_amd64.zip

unzip packer_1.3.1_linux_amd64.zip -d packer
sudo mv packer /usr/local/
echo 'export PATH="$PATH:/usr/local/packer"' >> sudo /etc/environment
source /etc/environment

#System76 Pop Theme
https://www.dropbox.com/s/qcss3ohm4k1xl20/Copy%20of%20PopTheme.zip?dl=0

#Virtualbox OSE
sudo apt-get install virtualbox virtualbox-dkms virtualbox-guest-additions-iso virtualbox-guest-dkms  virtualbox-qt libgsoap8 libvncserver1 virtualbox-guest-utils virtualbox-guest-x11

# PLUGINS SUBLIME #
Ir a la web de Package Control: https://packagecontrol.io/installation
(ctrl+alt+p install package)
DOCBLOCKR
EMMET
JSLINT
SUBLIME LINTER
SUBLIME CODEINTEL
BRACKET HIGHLIGHTER
SIDEBARENHANCEMENTS
SOLARIZED
ALIGNMENT
GIT
github tools
GITGUTTER
sublimegit
sublimegithub
gitignore
gitstatus
SVN
AllAutocomplete
LaravelBladeAutocomplete
SublimeREPL
ColorPicker
CanIUse
puppet
Sublinterpuppet
pretty yaml
codeigniter

# ZSH #
vim .zshrc
>>#ZSH_THEME="robbyrussell"
>>ZSH_THEME="random"

>>#plugins=(git)
>>
plugins=(
    asdf
    autopep8
    aws
    boot2docker
    bower
    brew
    bundler
    capistrano
    coffee
    colored-man-pages
    colorize
    command-not-found
    common-aliases
    compleat
    completion
    composer
    copybuffer
    copydir
    copyfile
    cp
    cpanm
    debian
    dircycle
    dirhistory
    dirpersist
    django
    docker
    docker-compose
    docker-machine
    dotenv
    encode64
    fasd
    Forklift
    geeknote
    gem
    git
    git_remote_branch
    git-extras
    git-flow
    git-flow-avh
    git-hubflow
    gitfast
    github
    gitignore
    go
    golang
    gradle
    grails
    history
    httpie
    jira
    kubectl
    laravel
    laravel4
    laravel5
    last-working-dir
    lol
    man
    marked2
    nanoc
    ng
    nmap
    node
    npm
    pass
    perl
    pip
    postgres
    profiles
    python
    rails
    rake
    rake-fast
    rbenv
    redis-cli
    repo
    rsync
    ruby
    rvm
    screen
    ssh-agent
    sublime
    sudo
    svn
    svn-fast-info
    systemd
    terminalapp
    terminitor
    themes
    thor
    torrent
    ubuntu
    urltools
    vagrant
    vi-mode
    vim-interaction
    virtualenv
    virtualenvwrapper
    vo-mode
    wd
    web-search
    wp-cli
    yarn
    yum
    zsh
    zsh_reload
    zsh-navigation-tools
)

 # You may need to manually set your language environment
 LANGUAGE=es_CL.UTF-8
 LANG=es_CL.UTF-8
 LC_CTYPE=es_CL.UTF-8
 LC_ALL=es_CL.UTF-8


#vagrant
##Plugins
vagrant plugin install vagrant-mutate vagrant-libvirt vagrant-vbguest vagrant-puppet-install vocker  vagrant-lxc vagrant-list vagrant-hosts vagrant-hostmanager vagrant-exec vagrant-camera vagrant-cachier sahara vagrant-scp

vagrant global-status

error de modulos => sudo sed -i'' "s/Specification.all = nil/Specification.reset/" /usr/lib/ruby/vendor_ruby/vagrant/bundler.rb

#KVM
(verificar virt activa en : grep --color -e svm -e vmx /proc/cpuinfo )

apt  install kvm virt-manager libvirt-bin ruby-libvirt qemu libvirt-bin virtinst virt-viewer ebtables dnsmasq libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev

adduser <suusuario> libvirt
adduser <suusuario> kvm

-En caso de error al iniciar la VM
editar /etc/libvirt/qemu.conf 
 y agregar:

user = "root" 
group = "root" 

systemctl restart libvirtd

#LXD
sudo apt-get install lxd lxd-client zfs
newgrp lxd
sudo lxd init

#RUBY (VIA RBENV)
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

env | grep PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

rbenv install 2.5.0
rbenv global 2.5.0
ruby -v

gem install bundler
rbenv rehash


#Rake
sudo gem install rake
sudo gem install bundler
sudo gem install gemspec
bundle install

#Brew
brew update
brew install python@2
brew install libmagic

#CAPISTRANO
sudo gem install capistrano
sudo gem install capistrano -v3.4.0
sudo gem install capistrano-passenger

#vagrant
##Plugins
vagrant plugin install vagrant-mutate vagrant-libvirt vagrant-vbguest vagrant-puppet-install vocker  vagrant-lxc vagrant-list vagrant-hosts vagrant-hostmanager vagrant-exec vagrant-camera vagrant-cachier sahara vagrant-scp

vagrant global-status

error de modulos => sudo sed -i'' "s/Specification.all = nil/Specification.reset/" /usr/lib/ruby/vendor_ruby/vagrant/bundler.rb

#PIP
pip install --upgrade pip
pip install virtualenvwrapper


#AWS Dragondisk
http://www.s3-client.com/download-s3-compatible-cloud-client.html

#NFS SERVER
apt-get install nfs-kernel-server 
vim /etc/exports
exportfs -a
sudo service nfs-kernel-server restart

#SYNCTHING
# Update and install syncthing:
sudo apt-get update
sudo apt-get install syncthing

#S3 DRAGONDISK
http://www.s3-client.com/download-s3-compatible-cloud-client.html

#SOAPUI
https://www.soapui.org/downloads/soapui.html

#DOCKER
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'

sudo apt-get update && apt-cache policy docker-engine

sudo apt-get install -y docker-engine

sudo systemctl status docker

##DOCKER MACHINE
 base=https://github.com/docker/machine/releases/download/v0.14.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine

#AWS-CLI
pip install awscli --upgrade --user

#GIT LFS

Ubuntu
Similar to Debian 7, Ubuntu 12 and similar Wheezy versions need to have a PPA repo installed to get git >= 1.8.2

sudo apt-get install software-properties-common to install add-apt-repository (or sudo apt-get install python-software-properties if you are on Ubuntu <= 12.04)

sudo add-apt-repository ppa:git-core/ppa

The curl script below calls apt-get update, if you aren't using it, don't forget to call apt-get update before installing git-lfs.
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs install


#ICONOS A LAS IZQUIERDA
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/DecorationLayout':<'close,minimize,maximize:'>}"

##################################################
#TERMINALCOLOR
#18CAE6
#6FC3DF
##########################################


