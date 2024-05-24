# default vim to nvim 
alias vim="nvim"

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
alias ls='lsd' # better ls
alias ll='ls -lF'
alias la='ls -A'
alias lla='ls -al'
alias l='ls -F -1'
alias lt='ls --tree'

# lls() {
#   /bin/ls -AlFbhv --color=always "$@" | less -XER
# }

# alert will send a desktop notification when command ends.
# input will be used to set notification text
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


alias tip='tips'
alias f='formatter'
alias wp="cd ~/workspace"
alias notes="code ~/notes"
alias lenny='echo -n "( ͡° ͜ʖ ͡°)" | xsel --clipboard'
alias shrug='echo -n "¯\_(ツ)_/¯" | xsel --clipboard'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias o='xdg-open'

alias preview="fzf --preview 'bat --color \"always\" {}'"

alias gentmp='date +tmp+%Y%m%d%H%M%S'
alias genpwd='cat /dev/urandom | tr -cd "3-9A-HJ-NP-Z" | head -c 32'

alias man=better_man #'if (( $(tput cols) <= 130 )); then MANWIDTH=$( (( $(tput cols) <= 130 )) && echo $(tput cols) || echo 120) man'
