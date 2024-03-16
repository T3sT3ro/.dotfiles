#!/bin/bash

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  # alias dir='dir --color=auto'
  # alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
lls() {
  ls -AlFbhv --color=always "$@" | less -XER
}
alias la='ls -A'
alias l='ls -F -1'


# alert will send a desktop notification when command ends.
# input will be used to set notification text
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


function webm2gif() {
  ffmpeg -i "$1" "${1%.webm}.gif"
}

function webm2mp4() {
  ffmpeg -i "$1" "${1%.webm}.mp4"
}

function yesno() {
  PROMPT=${1:-"Confirm?"}
  read -n 1 -p "$PROMPT (y/n)? " answer
  case ${answer:0:1} in
    y|Y )
      return 0
      ;;
    * )
      return 1
      ;;
  esac
}

alias tip='tips'
alias f='formatter'
alias wp="cd ~/workspace"
alias notes="code ~/notes"
alias lenny='echo -n "( ͡° ͜ʖ ͡°)" | xsel --clipboard'
alias shrug='echo -n "¯\_(ツ)_/¯" | xsel --clipboard'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias o='xdg-open'
alias copy='xclip --clipboard'

alias gentmp='date +tmp+%Y%m%d%H%M%S'
alias genpwd='cat /dev/urandom | tr -cd "3-9A-HJ-NP-Z" | head -c 32'

# MAN sizing of maxwidth 120 for terminals bigger than 120
better_man() {
  if (( $(tput cols) <= 130 )); then
    /usr/bin/man $@
  else
    MANWIDTH=120 /usr/bin/man $@
  fi
}

alias man=better_man #'if (( $(tput cols) <= 130 )); then MANWIDTH=$( (( $(tput cols) <= 130 )) && echo $(tput cols) || echo 120) man'

alias profilebashstartup='exec bash --rcfile ~/.bashrc.profiler'
