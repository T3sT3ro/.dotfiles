# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# escape sequences input (for example for colors): <CTRL>+V, <CTRL>+[, [, [code]

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# tooster
# =============================================
# aliases and utilities

# this tells anyone logged into machine that he is logged via SSH
# maybe not the best way (SSH_... could be better), but works
REMOTE=$(who am i | awk -F' ' '{printf $5}')
[[ $REMOTE =~ \([-a-zA-Z0-9\.]+\)$ ]] && REMOTE=true || REMOTE=false
export REMOTE

# alias to manage dotfiles.
function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@
}

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
alias la='ls -A'
alias l='ls -F -1'

# Add an "alert" alias for long running commands.  Use like so:
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4000
HISTFILESIZE=9000

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# alert will send a desktop notification when command ends.
# input will be used to set notification text
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# tldr completion
[ -f ~/.tldr-completion.bash ] && source ~/.tldr-completion.bash

# tab completion to attach to tmux session via `t [name]`
function _ttr_tmux_session_complete {
    COMPREPLY=($(compgen -W "$(tmux ls -F '#{session_name}')" "${COMP_WORDS[1]}"))
}

# creates new tmux session or attaches to a codename
function _ttr_new_tmux_session {
    if [[ $# -eq 0 ]]; then # create new session
        tmux new-session -s $(codename -s '_')
    else
        tmux attach-session -t $1
    fi
}

function webm2gif() {
    ffmpeg -i "$1" "${1%.webm}.gif"
}

alias ta='tmux attach -t'
alias ts='tmux switch -t'
alias tn=_ttr_new_tmux_session
alias t='tmux attach || _ttr_new_tmux_session'
alias tl='tmux ls'

complete -F _ttr_tmux_session_complete t

alias f='formatter'
alias wp="cd ~/workspace"
alias notes="code ~/notes.md"
alias lenny='echo -n "( ͡° ͜ʖ ͡°)" | xclip -sel c'
alias shrug='echo -n "¯\_(ツ)_/¯" | xclip -sel c'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias o='xdg-open'

# MAN sizing of maxwidth 120 for terminals bigger than 120
better_man() {
    if (( $(tput cols) <= 130 )); then
        /usr/bin/man $@ 
    else
        MANWIDTH=120 /usr/bin/man $@
    fi
}

alias man=better_man #'if (( $(tput cols) <= 130 )); then MANWIDTH=$( (( $(tput cols) <= 130 )) && echo $(tput cols) || echo 120) man'
# --------------------------------


# LESS coloring. Will guess based on content if can't find lexer
export LESSOPEN="| pygmentize -gO style=monokai %s" 
export LESS=' -R --mouse --wheel-lines=3' 

# MAN COLORING
export LESS_TERMCAP_mb=$'\e[1;5;32m' # start blink
export LESS_TERMCAP_md=$'\e[1;32m' # start bold
export LESS_TERMCAP_me=$'\e[0m'    # turn off bold, blink and underline
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;7;33m' # standout aka search ???
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# sourcing and path modifications
# =============================================
#

# custom prompt by Tooster
. ~/.prompt.sh

# autojump
if [ -d /usr/share/autojump ]; then
    . /usr/share/autojump/autojump.sh
fi

# setup ruby gems PATH
if command -v ruby >/dev/null && command -v gem >/dev/null; then
    RUBYPATH="$(ruby -r rubygems -e 'puts Gem.user_dir')"
    export PATH="$RUBYPATH/bin:$PATH"
fi

#setup TheFuck
if ( command -v thefuck >/dev/null ); then
    eval "$(thefuck --alias)"
fi

# setup ANTLR
export CLASSPATH=".:/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH"
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

#setup NODE
export N_PREFIX="$HOME/.n"
export PATH=$N_PREFIX/bin:$PATH

# RUST - cargo
if [ -d "$HOME/.cargo/" ]; then
    . "$HOME/.cargo/env"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tooster/.sdkman"
[[ -s "/home/tooster/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tooster/.sdkman/bin/sdkman-init.sh"

