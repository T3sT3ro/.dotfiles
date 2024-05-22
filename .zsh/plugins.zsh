# old plugins array from oh-my-zsh
plugins=(
    # git # unneeded
  colored-man-pages
  command-not-found
  copyfile
  copypath
  dirhistory
  docker
  docker-compose
  fzf
  gh
  npm
  pip
  python
  sudo
  tldr
  tmux
  vscode
  zoxide 
  # zsh-autocomplete # the history search is confusing and the terminal line jumps around
  zsh-autosuggestions
  zsh-syntax-highlighting
  rustup
  zsh-bash-completions-fallback # to make existing bash completions work <https://github.com/3v1n0/zsh-bash-completions-fallback>
)

# config
#
# to fix fzf vs zsh-autocomplete in `kill` problem
zstyle ':autocomplete:tab:*' completion fzf
