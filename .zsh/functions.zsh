webm2gif() {
  ffmpeg -i "$1" "${1%.webm}.gif"
}

webm2mp4() {
  ffmpeg -i "$1" "${1%.webm}.mp4"
}


# MAN sizing of maxwidth 120 for terminals bigger than 120
better_man() {
  if (( $(tput cols) <= 130 )); then
    /usr/bin/man $@
  else
    MANWIDTH=120 /usr/bin/man $@
  fi
}



dotfiles-seppuku() {
    dotfiles checkout -f
    dotfiles pull 
}

compdef dotfiles='git'

avfspath() {
  echo -n "$HOME/.avfs$(realpath $1)"
}

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}
