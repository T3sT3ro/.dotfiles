#!/bin/bash

################################################
# THIS IS A TEMPORARY BOOTSTRAP SCRIPT
# The goal is to finally move to Nix managed
# dotfiles and packages
################################################

function step() {
  echo -e "\033[1;34m$1\033[0m"
}

step "Entering home directory for safety"
cd ~ || exit

step "Making sure core utilities are installed"
sudo apt install -y curl wget git

step "cloning dotfiles with shallow submodules"
git clone --bare --recurse-submodules --shallow-submodules https://github.com/T3sT3ro/.dotfiles.git ~/.dotfiles

step "aliasing dotfiles temporarily"
alias dotfiles="/usr/bin/git --git-dir=~/.dotfiles/ --work-tree=~"

export DOTFILES_BACKUP_DIR=$HOME/.dotfiles-backup

step "Backing up all stock dotfiles to $DOTFILES_BACKUP_DIR"
for f in $(dotfiles checkout 2>&1 | grep -E '^\s+\.' | awk '{print $1}'); do
  cp --parents -r "$f" "$DOTFILES_BACKUP_DIR" && rm -i "$f"
done

step "setting up local dotfiles config"
dotfiles config --local status.showUntrackedFiles no

step "trying to checkout dotfiles"
dotfiles checkout


################################################
# PPA setup
################################################

step "setting up wezterm PPA"
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
$ echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

step "setting up gh (github CLI) PPA"
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) &&
  sudo mkdir -p -m 755 /etc/apt/keyrings &&
  wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

step "updating PPA repositories"
sudo apt update

step "installing nala"
sudo apt install nala -y

################################################
# regular package and program installation
################################################

step "installing packages"
sudo nala install -y zsh wezterm gh file-roller gnome-tweaks

step "installing fonts and nerdfonts"
fc-cache -fv

step "installing starship"
curl -sS https://starship.rs/install.sh | sh

step "installing VSCode"
dpkg -i https://code.visualstudio.com/docs/?dv=linux64_deb

step "installing neovim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# install rust
step "installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# install global cargo updater
step "installing cargo updater"
cargo install cargo-update
# update all global crates
step "updating and installing all global cargo packages"
cargo install-update --all



# final upgrade
step "running global nala upgrade"
sudo nala upgrade


################################################
# Dconf - system settings management
################################################

step "dumping dconf settings"
dconf dump / > "$DOTFILES_BACKUP_DIR"/dconf.conf

step "loading global dconf settings"
dconf load / < ~/.dotfiles/dconf-dump.conf

step "entering zsh"
exec zsh


