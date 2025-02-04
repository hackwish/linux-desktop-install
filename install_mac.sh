#!/bin/bash

# Major initial configuration part is based on https://github.com/thoughtbot/laptop
# Others sources:
# https://gist.github.com/EmanuelCadems/0a600dfb692213d88b0ce91ddf0fb0b2
# https://gist.github.com/mrlesmithjr/f3c15fdd53020a71f55c2032b8be2eda

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\\n" "$text" >> "$zshrc"
    else
      printf "\\n%s\\n" "$text" >> "$zshrc"
    fi
  fi
}

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

# shellcheck disable=SC2016
append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'

# Determine Homebrew prefix
arch="$(uname -m)"
if [ "$arch" = "arm64" ]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi

update_shell() {
  local shell_path;
  shell_path="$(command -v zsh)"

  fancy_echo "Changing your shell to zsh ..."
  if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
    fancy_echo "Adding '$shell_path' to /etc/shells"
    sudo sh -c "echo $shell_path >> /etc/shells"
  fi
  sudo chsh -s "$shell_path" "$USER"
}

case "$SHELL" in
  */zsh)
    if [ "$(command -v zsh)" != "$HOMEBREW_PREFIX/bin/zsh" ] ; then
      update_shell
    fi
    ;;
  *)
    update_shell
    ;;
esac

# checks architecture
if [ "$(uname -m)" = "arm64" ]
  then
  # checks if Rosetta is already installed
  if ! pkgutil --pkg-info=com.apple.pkg.RosettaUpdateAuto > /dev/null 2>&1
  then
    echo "Installing Rosetta"
    # Installs Rosetta2
    softwareupdate --install-rosetta --agree-to-license
  else
    echo "Rosetta is installed"
  fi
fi

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    append_to_zshrc "eval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\""

    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force # https://github.com/Homebrew/brew/issues/1151
brew bundle --file=- <<EOF
tap "thoughtbot/formulae"
tap "homebrew/services"
tap "heroku/brew"

# Unix
brew "gcc"
brew "git"
brew "go"
brew "libmagic"
brew "openssl"
brew "universal-ctags"
EOF

fancy_echo "Configuring asdf version manager ..."
if [ ! -d "$HOME/.asdf" ]; then
  brew install asdf
  append_to_zshrc "source $(brew --prefix asdf)/libexec/asdf.sh" 1
fi

alias install_asdf_plugin=add_or_update_asdf_plugin
add_or_update_asdf_plugin() {
  local name="$1"
  local url="$2"

  if ! asdf plugin-list | grep -Fq "$name"; then
    asdf plugin-add "$name" "$url"
  else
    asdf plugin-update "$name"
  fi
}

# shellcheck disable=SC1091
. "$(brew --prefix asdf)/libexec/asdf.sh"
add_or_update_asdf_plugin "ruby" "https://github.com/asdf-vm/asdf-ruby.git"
add_or_update_asdf_plugin "nodejs" "https://github.com/asdf-vm/asdf-nodejs.git"

install_asdf_language() {
  local language="$1"
  local version
  version="$(asdf list-all "$language" | grep -v "[a-z]" | tail -1)"

  if ! asdf list "$language" | grep -Fq "$version"; then
    asdf install "$language" "$version"
    asdf global "$language" "$version"
  fi
}

fancy_echo "Installing latest Ruby ..."
install_asdf_language "ruby"
gem update --system
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

if ! [ -d ~/.oh-my-zsh ]
then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

sed -i -e 's/plugins=(git)/plugins=(git asdf rails bundler ruby)/g' ~/.zshrc

# Custom oh-my-zsh theme
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="pygmalion"/g' ~/.zshrc

# if [[ $(cat ~/.zshrc | grep 'LC_ALL') == "" ]]; then
#   cat <<EOT >> ~/.zshrc
#   # Add custom LANG configs for Fastlane
#   export LC_ALL=en_US.UTF-8
#   export LANG=en_US.UTF-8
#   export LANGUAGE=en_US.UTF-8
# EOT
# fi

# Fix oh-my-zsh permissions issue
# chmod -R 644 /usr/local/share/zsh
# sudo chmod -R 644 /usr/local/share/zsh/site-functions

#Ansible
echo "Iniciando Ansible Deploy"
brew install ansible
ANSIBLE_CUSTOM_DIR=`pwd`

echo "instalando colecciones"
ansible-galaxy collection install --force ansible.posix
ansible-galaxy collection install --force community.docker
ansible-galaxy collection install --force community.general
ansible-galaxy collection install --force community.sops
ansible-galaxy collection install --force kubernetes.core

echo "Descargando roles"
ansible-galaxy install --force -r ${ANSIBLE_CUSTOM_DIR}/ansible/requirements_mac.yml

# echo "Comienza Deployment con Ansible"
# ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/mac.yml

echo "Comienza Deployment con Ansible"
echo "Opciones de Instalación: "

OPCIONES="desktop devops salir"

PS3="Selecciona una opción: " 

select installer in $OPCIONES;
do
  case $installer in
	desktop)
		echo "Se inicia la instalación de $installer"
		ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/mac-desktop.yml
        break
		;;
	devops)
		echo "Se inicia la instalación de $installer"
		ansible-playbook -vvv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/playbooks/mac-devops.yml
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
