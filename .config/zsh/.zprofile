#!/bin/zsh
#
# .zprofile - Zsh file loaded on login.
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

#
# Editors
#

export EDITOR="${EDITOR:-nvim}"
export SUDO_EDITOR="${SUDO_EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export PAGER="${PAGER:-bat}"

#
# Paths
#

export N_PREFIX="$HOME/.n"
export SDKMAN_DIR="$HOME/.sdkman"
export NODE_PATH=$N_PREFIX/bin

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $HOME/.local/bin(N)
  $N_PREFIX/bin(N)
  $HOME/.cargo/bin(N)
  $path
)
