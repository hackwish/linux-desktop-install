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

HOMEBREW_PREFIX="$HOME/homebrew"

# if [ -d "$HOMEBREW_PREFIX" ]; then
#   if ! [ -r "$HOMEBREW_PREFIX" ]; then
#     sudo chown -R "$LOGNAME:admin" /usr/local
#   fi
# else
#   sudo mkdir "$HOMEBREW_PREFIX"
#   sudo chflags norestricted "$HOMEBREW_PREFIX"
#   sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
# fi

# update_shell() {
#   local shell_path;
#   shell_path="$(command -v zsh)"

#   fancy_echo "Changing your shell to zsh ..."
#   if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
#     fancy_echo "Adding '$shell_path' to /etc/shells"
#     sudo sh -c "echo $shell_path >> /etc/shells"
#   fi
#   sudo chsh -s "$shell_path" "$USER"
# }

# case "$SHELL" in
#   */zsh)
#     if [ "$(command -v zsh)" != '/usr/local/bin/zsh' ] ; then
#       update_shell
#     fi
#     ;;
#   *)
#     update_shell
#     ;;
# esac

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  rm -rf $HOME/homebrew
  git clone https://github.com/Homebrew/brew $HOME/homebrew
  eval "$($HOME/homebrew/bin/brew shellenv)"
  append_to_zshrc '# recommended by brew doctor'

  # shellcheck disable=SC2016
  append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1
  append_to_zshrc 'export PATH="/usr/local/sbin:$PATH"' 1
  append_to_zshrc 'export PATH="$HOME/homebrew/bin:$PATH"' 1

  export PATH="/usr/local/bin:$PATH"
  export PATH="$HOME/homebrew/bin:$PATH"
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
brew bundle --file=- <<EOF
tap "thoughtbot/formulae"
tap "homebrew/services"
tap "universal-ctags/universal-ctags"
tap "heroku/brew"
tap "homebrew/cask-fonts"
tap "homebrew/cask"
tap "homebrew/cask-versions"
tap "homebrew/core"
tap "adoptopenjdk/openjdk"
brew "universal-ctags", args: ["HEAD"]
brew "git"
brew "ansible"
EOF

# fancy_echo "Update heroku binary ..."
# brew unlink heroku
# brew link --force heroku

fancy_echo "Configuring asdf version manager ..."
if [ ! -d "$HOME/.asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  append_to_zshrc "source $HOME/.asdf/asdf.sh" 1
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

# shellcheck disable=SC1090
source "$HOME/.asdf/asdf.sh"
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

fancy_echo "Installing latest Node ..."
bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring"
install_asdf_language "nodejs"

if ! [ -d ~/.oh-my-zsh ]
then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

sed -i -e 's/plugins=(git)/plugins=(git asdf rails bundler ruby)/g' ~/.zshrc

# if ! [ -f ~/Library/Fonts/Roboto\ Mono\ for\ Powerline.ttf ]
# then
#   fancy_echo "Installing Powerline fonts"
#     git clone https://github.com/powerline/fonts
#     # install
#     ./fonts/install.sh
#     # clean-up a bit
#     rm -rf fonts
# fi

# Custom oh-my-zsh theme
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="pygmalion"/g' ~/.zshrc

# Add Custom config on zshrc
if [[ $(cat ~/.zshrc | grep 'NVM_DIR') == "" ]]; then
  cat <<EOT >> ~/.zshrc
  # Add custom NVM configs
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
EOT
fi

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

# if ! [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]
# then
#     git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
#     sed -i -e 's/ZSH_THEME=robbyrussell/ZSH_THEME=powerlevel9k\/powerlevel9k/g' ~/.zshrc
# fi

# if [ -f "$HOME/.laptop.local" ]; then
#   fancy_echo "Running your customizations from ~/.laptop.local ..."
#   # shellcheck disable=SC1090
#   . "$HOME/.laptop.local"
# fi

#Ansible
echo "Iniciando Ansible Deploy"
ANSIBLE_CUSTOM_DIR=`pwd`

echo "instalando colecciones"
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.docker
ansible-galaxy collection install community.sops
ansible-galaxy collection install community.general

echo "Descargando roles"
ansible-galaxy install --force -r ${ANSIBLE_CUSTOM_DIR}/ansible/requirements.yml

# echo "Comienza Deployment con Ansible"
# ansible-playbook -vv -i ${ANSIBLE_CUSTOM_DIR}/ansible/hosts ${ANSIBLE_CUSTOM_DIR}/ansible/mac.yml