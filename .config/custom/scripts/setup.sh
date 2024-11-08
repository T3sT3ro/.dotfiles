#!/bin/bash

################################################
# THIS IS A TEMPORARY BOOTSTRAP SCRIPT
# The goal is to finally move to Nix managed
# dotfiles and packages
################################################

# make sure we are in the home dir
cd ~ || exit

# install core utilities
sudo apt install -y curl, wget, git

# clone dotfiles
git clone --recurse-submodules --shallow-submodules git@github.com:T3sT3ro/.dotfiles.git ~/.dotfiles

# alias dotfiles temporarily until the repo is cloned
alias dotfiles="/usr/bin/git --git-dir=~/.dotfiles/ --work-tree=~"

export DOTFILES_BACKUP_DIR=$HOME/.dotfiles-backup

echo "Backing up all stock dotfiles"
for f in $(dotfiles checkout 2>&1 | grep -E '^\s+\.' | awk '{print $1}'); do
  cp --parents -r "$f" "$DOTFILES_BACKUP_DIR" && rm -i "$f"
done

# set up dotfiles
dotfiles checkout
dotfiles config status.showUntrackedFiles no


################################################
# PPA setup
################################################

# wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
$ echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

# github cli
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) &&
  sudo mkdir -p -m 755 /etc/apt/keyrings &&
  wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

# update PPAs
sudo apt update
sudo apt install nala -y

################################################
# regular package and program installation
################################################

# use nala
sudo nala install -y zsh wezterm gh file-roller gnome-tweaks

# update font cache to include nerdfonts
fc-cache -fv

# starship for shell prompt
curl -sS https://starship.rs/install.sh | sh

# install VSCode
dpkg -i https://code.visualstudio.com/docs/?dv=linux64_deb

# install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# install global cargo updater
cargo install install-update
# update all global crates
cargo install-update --all



# final upgrade
sudo nala upgrade


################################################
# Dconf - system settings management
################################################
dconf dump / > "$DOTFILES_BACKUP_DIR"/dconf.conf
dconf load / < ~/.dotfiles/dconf-dump.conf

# enter the proper shell
exec zsh


