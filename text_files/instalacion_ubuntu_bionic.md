# INSTALAR UBUNTU 18.04 - MINT 19 Y DERIVADOS #

## post instalaciÃ³n ##
``sudo apt update``
``sudo apt upgrade``
``sudo apt dist-upgrade``

#ADD REPOS

sudo add-apt-repository ppa:numix/ppa -y
sudo add-apt-repository ppa:system76/pop -y
sudo add-apt-repository ppa:system76-dev/stable -y
sudo add-apt-repository ppa:git-core/ppa -y
sudo add-apt-repository ppa:papirus/papirus -y
sudo apt-add-repository ppa:nilarimogard/webupd8 -y

#Software BASE
sudo apt install -y curl wget vim apt-transport-https ca-certificates curl software-properties-common

#Repos y llaves adicionales
##SUBLIME TEXT 3
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"

##SUBLIME MERGE
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

##SYNCTHING
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

##NODEJS
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

##DOCKER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable edge"

##GIT-LFS
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
**en caso de linux mint cambiar linuxmint tara, por ubuntu bionic**
/etc/apt/sources.list.d/github_git-lfs.list

##Google Cloud SDK
### Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-bionic"

### Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

### Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


1. actualizar
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade

apt-cache policy docker-ce

sudo apt update

sudo apt install -y ubuntu-restricted-extras 

sudo apt install -y linux-headers-$(uname -r) linux-headers-generic build-essential checkinstall make automake cmake autoconf git libdvd-pkg  intel-microcode synaptic apt-xapian-index gdebi preload file-roller p7zip-full p7zip-rar rar unrar zip unzip unace p7zip-full p7zip-rar sharutils mpack arj brasero-cdrkit k3b vlc browser-plugin-vlc soundconverter  catfish hardinfo gufw ttf-mscorefonts-installer libncurses5-dev build-essential module-assistant lm-sensors hddtemp pepperflashplugin-nonfree icedtea-plugin ttf-mscorefonts-installer ttf-bitstream-vera ttf-dejavu terminator htop dconf-editor fonts-noto lshw nmap curl xclip mailutils postfix meld zsh rar unace p7zip-full p7zip-rar sharutils mpack arj htop atop nmon postfix lshw tcpdump ncdu multitail ccze nano iftop stress snmp snmp-mibs-downloader snmpd pv iotop smartmontools python python-setuptools nmap powertop collectd default-jre default-jdk openssh-server  openssh-client xinetd telnetd subversion nfs-kernel-server  nfs-common vim vim-common lm-sensors netcat automake autoconf libreadline-dev  libssl-dev libyaml-dev libffi-dev libtool unixodbc-dev  ubuntu-restricted-extras synaptic terminator default-jre default-jdk chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg adobe-flashplugin shutter vim-gnome vim-gtk  vim-gui-common vim-snippets gimp swaks gir1.2-gtop-2.0 gir1.2-networkmanager-1.0  gir1.2-clutter-1.0 nodejs mysql-workbench mysql-workbench-data quodlibet redshift* filezilla* siege libsvn-java openvpn network-manager-openvpn network-manager-openvpn-gnome git-ftp  pgadmin3 rbenv ssh-askpass dia kdeconnect nvidia-cuda-dev nvidia-cuda-toolkit libssl-dev cmake cmake-curses-gui libjansson-dev clang libffi-dev nodejs yarn libgdbm-dev libncurses5-dev automake libtool bison libffi-dev linuxbrew-wrapper libmagic-dev  libjansson-dev clang psensor playonlinux libspice-client-gtk-3.0 software-properties-common gnome-tweak-tool gnome-shell-extensions gcc g++ make wine1.8 tor torbrowser-launcher numix* sublime-text lxd lxd-client nfs-kernel-server syncthing docker git-lfs zsh python-pip tmux plank snapd apt-transport-https google-cloud-sdk kubectl google-cloud-sdk-app-engine-java google-cloud-sdk-app-engine-python  google-cloud-sdk-pubsub-emulator google-cloud-sdk-bigtable-emulator  google-cloud-sdk-datastore-emulator python-pip libpython-dev git-flow docker-ce virt-manager libvirt-bin ruby-libvirt qemu libvirt-bin virtinst virt-viewer ebtables dnsmasq libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev arc-theme spotify-client papirus-icon-theme gpick pulseaudio-equalizer qemu-kvm moreutils jq libxml-writer-perl libguestfs-perl uuid-runtime golang-go ruby-full awscli mint-meta-codecs snapd mint-meta-mate compizconfig-settings-manager compiz-plugins-extra compiz compiz-plugins-extra compiz compizconfig-settings-manager dconf-tools boinc-client boinc-manager boinc-screensaver ia32-libs libstdc++6 libstdc++5 freeglut3 whois linux-generic xserver-xorg libegl1-mesa xserver-xorg-video-all xserver-xorg-input-all linux-signed-generic putty-tools sublime-merge

ssh-keygen && fc-cache -fv && sudo sensors-detect && sudo service kmod start && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git config --global color.ui true
git config --global user.email "marcelo.cardenasc@gmail.com"
git config --global user.name "hackwish"

#Ejecutar Docker como user
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG
sudo usermod -aG docker username


7. Otros paquetes (desde la web - DEB)

#GIT FLOW
wget --no-check-certificate -q  https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh && sudo bash gitflow-installer.sh install stable; rm gitflow-installer.sh

#MINIKUBE
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.27.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

#Atom Editor
wget -O atom-amd64.deb https://atom.io/download/deb
sudo gdebi atom-amd64.deb

#Robo3T (MongoDb Visualizer)
https://download.robomongo.org/1.2.1/linux/robo3t-1.2.1-linux-x86_64-3e50a65.tar.gz


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
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
exec $SHELL

eval "$(rbenv init -)"

rbenv install 2.5.0
rbenv global 2.5.0
ruby -v

gem install bundler
rbenv rehash

#Rake
gem install rake
gem install gemspec

#yarn
yarn install

#CAPISTRANO
gem install capistrano
gem install capistrano -v3.4.0
gem install capistrano-passenger

#Veewee
gem install fog --version 1.8
gem install veewee

#PIP
pip install --upgrade pip
python -m pip install virtualenvwrapper --user
python -m pip install --upgrade pip setuptools  --user

#AWS-CLI
python -m pip install awscli --upgrade --user

#Stylus
sudo npm install stylus -g

#Yeoman
sudo npm install -g yo

#Generator-rancher-catalog
sudo npm install -g generator-rancher-catalog

#Brew
brew update
brew install gcc
brew vendor-install ruby
brew install python@2
brew install libmagic

#Packer
wget https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_amd64.zip

unzip packer_1.3.1_linux_amd64.zip -d packer
sudo mv packer /usr/local/
##Editar y agregar
/etc/environment

PATH="$PATH:/usr/local/packer" 

##ejecutar
source /etc/environment


############################################

#Chrome
https://www.google.com/chrome/

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

#System76 Pop Theme
https://www.dropbox.com/s/qcss3ohm4k1xl20/Copy%20of%20PopTheme.zip?dl=0

#Visual Code Studio
https://code.visualstudio.com/Download

#SOAPUI
https://www.soapui.org/downloads/soapui.html

######################################################
######################################################
#vagrant
##Plugins
vagrant plugin install vagrant-mutate vagrant-libvirt vagrant-vbguest vagrant-puppet-install vocker  vagrant-lxc vagrant-list vagrant-hosts vagrant-hostmanager vagrant-exec vagrant-camera vagrant-cachier sahara vagrant-scp

vagrant global-status

error de modulos => sudo sed -i'' "s/Specification.all = nil/Specification.reset/" /usr/lib/ruby/vendor_ruby/vagrant/bundler.rb

#LXD
newgrp lxd
sudo lxd init

# ZSH #
vim .zshrc
>>#ZSH_THEME="robbyrussell"
>>ZSH_THEME="random"

>>#plugins=(git)
>>
plugins=(
    aws
    bower
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
    dirpersist
    django
    docker
    docker-compose
    docker-machine
    dotenv
    encode64
    fasd
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


# PLUGINS SUBLIME #
Ir a la web de Package Control: https://packagecontrol.io/installation
(ctrl+alt+p install package)
(o instalar manualmente en Linux: ~/.config/sublime-text-3/Packages/)

ALIGNMENT: git clone https://github.com/wbond/sublime_alignment.git
AllAutocomplete: git clone https://github.com/alienhard/SublimeAllAutocomplete.git
Anaconda : git clone https://github.com/DamnWidget/anaconda.git
Ansible : git clone https://github.com/clifford-github/sublime-ansible.git
Ansible Vault : git clone https://github.com/adambullmer/sublime_ansible_vault.git
Ansible​Snippets : git clone https://github.com/seregatte/AnsibleSnippets.git
BeautifyRuby: git clone https://github.com/CraigWilliams/BeautifyRuby.git
Bootstrap 3 Autocomplete : git clone https://github.com/webchun/bootstrap-3-sublime-autocomplete.git
Bootstrap 4 Autocomplete : git clone https://github.com/webchun/bootstrap-4-sublime-autocomplete.git
BRACKET HIGHLIGHTER: git clone https://github.com/facelessuser/BracketHighlighter.git
Bracket​Guard: git clone https://github.com/philippotto/Sublime-BracketGuard.git
Cake​PHP (tmbundle) : git clone https://github.com/cakephp/cakephp-tmbundle.git CakePHP.tmbundle
Cap​Rails : git clone https://github.com/schneidmaster/cap_rails.git
codeigniter: git clone https://github.com/mpmont/ci-snippets.git
Code​Igniter 2 Model​Controller : git clone https://github.com/todorowww/st2-snippet-ci2-mc.git
Code​Igniter Utilities : git clone https://github.com/RoverWire/codeigniter-utilities.git
Color Highlighter : git clone https://github.com/Monnoroch/ColorHighlighter.git
Color Sublime : git clone https://github.com/Colorsublime/Colorsublime-Plugin.git
ColorPick: git clone https://github.com/jnordberg/sublime-colorpick.git
ColorPicker: git clone https://github.com/weslly/ColorPicker.git
DOCBLOCKR : git clone https://github.com/spadgos/sublime-jsdocs.git
Docker Based Build Systems : git clone https://github.com/domeide/sublime-docker.git
Dockerfile Syntax Highlighting: git clone https://github.com/asbjornenge/Docker.tmbundle.git
EML Syntax : git clone https://github.com/jacobmovingfwd/eml-syntax.git
EMMET : git clone https://github.com/sergeche/emmet-sublime.git
ERB Autocomplete : git clone https://github.com/CasperLaiTW/ERBAutocomplete.git
Flashback : git clone https://github.com/apiad/sublime-flashback.git
Flask Completions : git clone https://github.com/geekpradd/Flask-Sublime.git 
fundamentals Snippets : git clone https://github.com/thespacedoctor/fundamentals-Sublime-Snippets.git
Git blame : git clone https://github.com/frou/st3-gitblame.git
Git Conflict Resolver : git clone https://github.com/Zeeker/sublime-GitConflictResolver.git
GIT: git clone https://github.com/kemayo/sublime-text-git.git
GITGUTTER: git clone https://github.com/jisaacks/GitGutter.git
Github Color Theme : git clone https://github.com/AlexanderEkdahl/github-sublime-theme.git
Github Notifications : git clone https://github.com/unknownuser88/github-notifications.git
github tools: git clone https://github.com/temochka/sublime-text-2-github-tools.git
gitignore: git clone https://github.com/kevinxucs/Sublime-Gitignore.git
Gitlab​Integrate : git clone https://github.com/SnoringFrog/GitlabIntegrate.git
gitstatus: git clone https://github.com/vlakarados/gitstatus.git
Git​Commit​Msg : git clone https://github.com/cbumgard/GitCommitMsg.git
Git​Diff​View : git clone https://github.com/predragnikolic/sublime-git-diff-view.git
Git​Hub​Issue : git clone https://github.com/divinites/gissues.git
Git​Status​Bar : git clone https://github.com/randy3k/GitStatusBar.git
Git​Syntaxes : git clone https://github.com/vovkkk/sublime_git_syntaxes.git
Jenkins Dashboard : git clone https://github.com/benmatselby/sublime-jenkins-dashboard.git
Jenkinsfile : git clone https://github.com/june07/sublime-Jenkinsfile.git
JSLINT: git clone https://github.com/73rhodes/Sublime-JSLint.git
JSONLINT: git clone https://bitbucket.org/hmml/jsonlint.git
Kubernetes Manifest Autocomplete: git clone https://github.com/xr1337/sublime-kubernetes-autocomplete.git
Laravel 4 Artisan : git clone https://github.com/evgeny-golubev/Laravel-4-Artisan.git
Laravel 4 Snippets : git clone https://github.com/samvasko/laravel4-snippets.git
Laravel 5 Artisan : git clone https://github.com/dydx/Laravel-5-Artisan.git
Laravel 5 Snippets : git clone https://github.com/Lykegenes/laravel-5-snippets.git
Laravel Blade Auto​Complete : git clone https://github.com/ahmedash95/sublime-laravel-blade-autocomplete.git
Laravel Blade Highlighter : git clone https://github.com/Medalink/laravel-blade.git
Laravel Bootstrapper Snippets : git clone https://github.com/patricktalmadge/Bootstrapper_snippets.git
Laravel Generator : git clone https://github.com/gnarula/sublime-laravelgenerator.git
Laravel Migrations Snippets : git clone https://github.com/marceloxp/laravel_migration_snippets.git
LiveReload: git clone https://github.com/alepez/LiveReload-sublimetext3.git
Live​Reload​Make : git clone https://github.com/alepez/LiveReloadMake-sublimetext3.git
Markdown​Code​Block​Wrapper : git clone https://github.com/kenspirit/MarkdownCodeBlockWrapper.git
Mongo​DB - PHP Completions : git clone https://github.com/Kristories/Sublime-Mongo-PHP.git
My​SQL Snippets : git clone https://github.com/korniychuk/sublime-sql-snippets.git
My​Sublime​QL : git clone https://github.com/biannetta/MySublimeQL.git
Neon Color Scheme : git clone https://github.com/MattDMo/Neon-color-scheme.git
Open in Git Repository : git clone https://github.com/arnellebalane/sublime-open-in-git-repository.git
Pg​SQL : git clone https://github.com/jobywalker/PgSQL-Sublime.git
Postgre​SQL Syntax Highlighting : git clone https://github.com/tkopets/sublime-postgresql-syntax.git+
Pretty Ruby : git clone https://github.com/gbaptista/sublime-3-pretty-ruby.git
pretty yaml: git clone https://github.com/aukaost/SublimePrettyYAML.git
puppet: git clone https://github.com/russCloak/SublimePuppet.git
Quick​Rails : git clone https://github.com/danpe/QuickRails.git
Rails Developer Snippets : git clone https://github.com/tennantje/railsdev-sublime-snippets.git
Rake : git clone https://github.com/SublimeText/Rake.git
Ruby on Rails snippets : git clone https://github.com/tadast/sublime-rails-snippets.git
Shell Exec : git clone https://github.com/gbaptista/sublime-3-shell-exec.git
SIDEBARENHANCEMENTS: git clone https://github.com/titoBouzout/SideBarEnhancements.git
Simple FTP Deploy : git clone https://github.com/HexRx/simple-ftp-deploy.git
SQLPlus : git clone https://github.com/bofm/sublime_sqlplus.git
SQLTools : git clone https://github.com/mtxr/SublimeText-SQLTools.git
SUBLIME CODEINTEL: git clone https://github.com/spectacles/CodeComplice.git
SUBLIME LINTER: git clone https://github.com/SublimeLinter/SublimeLinter.git
sublimegit: git clone https://github.com/SublimeGit/SublimeGit.git
sublimegithub: git clone https://github.com/bgreenlee/sublime-github.git
SublimeLinter-pyyaml : git clone https://github.com/SublimeLinter/SublimeLinter-pyyaml.git
SublimeREPL: git clone https://github.com/wuub/SublimeREPL.git
Sublime​Linter-contrib-ansible-lint : git clone https://github.com/mliljedahl/SublimeLinter-contrib-ansible-lint.git
Sublime​Linter-contrib-dockerfilelint : git clone https://github.com/prog1dev/SublimeLinter-contrib-dockerfilelint.git
Sublime​Linter-contrib-jslint : git clone https://github.com/devdoc/SublimeLinter-jslint.git
Sublime​Linter-contrib-puppet-lint : git clone https://github.com/dschaaff/SublimeLinter-puppet-lint.git
Sublime​Linter-contrib-yaml-lint : git clone https://github.com/witsec/SublimeLinter-contrib-yaml-lint.git
Sublime​Linter-contrib-yaml-lint : git clone https://github.com/witsec/SublimeLinter-contrib-yaml-lint.git
Sublime​Linter-contrib-yamllint : git clone https://github.com/thomasmeeus/SublimeLinter-contrib-yamllint.git
Sublime​Linter-ruby : git clone https://github.com/SublimeLinter/SublimeLinter-ruby.git
Sublinterpuppet: git clone https://github.com/dschaaff/SublimeLinter-puppet.git
subversion_for_sublime_txt​3 : git clone https://github.com/xiewandongqq/subversion_for_sublime_txt3.git
Sub​Notify : git clone https://github.com/facelessuser/SubNotify.git
Terminal: git clone https://github.com/wbond/sublime_terminal.git
Ticket​Master : git clone https://github.com/amit-bansil/TicketMaster.git
YAML Nav : git clone https://github.com/ddiachkov/sublime-yaml-nav.git
Yii​2 Auto-complete : git clone https://github.com/udokmeci/sublime-yii2-autocomplete.git
ZSH : git clone https://github.com/molovo/sublime-zsh.git


##########################################
#TERMINALCOLOR
#18CAE6
##########################################

##############################################
##############################################

#Virtualbox OSE
sudo apt-get install virtualbox virtualbox-dkms virtualbox-guest-additions-iso virtualbox-guest-dkms  virtualbox-qt libgsoap8 libvncserver1 virtualbox-guest-utils virtualbox-guest-x11

#KVM
(verificar virt activa en : grep --color -e svm -e vmx /proc/cpuinfo )

adduser <suusuario> libvirt
adduser <suusuario> kvm

-En caso de error al iniciar la VM
editar /etc/libvirt/qemu.conf 
 y agregar:

user = "root" 
group = "root" 

systemctl restart libvirtd

#AWS Dragondisk
http://www.s3-client.com/download-s3-compatible-cloud-client.html

#NFS SERVER
apt-get install nfs-kernel-server 
vim /etc/exports
exportfs -a
sudo service nfs-kernel-server restart

#S3 DRAGONDISK
http://www.s3-client.com/download-s3-compatible-cloud-client.html

##DOCKER MACHINE
 base=https://github.com/docker/machine/releases/download/v0.14.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine

#ICONOS A LAS IZQUIERDA
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/DecorationLayout':<'close,minimize,maximize:'>}"





