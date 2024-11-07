# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/workspace/ttr}

# ZSH config
export BASHDOTDIR=${BASHDOTDIR:-$XDG_CONFIG_HOME/bash}

export GPG_TTY=$(tty)

# escape sequences input (for example for colors): <CTRL>+V, <CTRL>+[, [, [code]

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# tooster
# =============================================
# aliases and utilities

. "$BASHDOTDIR/remote.sh"
. "$BASHDOTDIR/dotfiles.sh"
. "$BASHDOTDIR/aliases.sh"
. "$BASHDOTDIR/tmux.sh"
. "$BASHDOTDIR/todo.sh"
# . $BASHDOTDIR/conda.sh
. "$BASHDOTDIR/ferium.sh"
. "$BASHDOTDIR/banner.sh"
. "$BASHDOTDIR/prompt.sh"

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

# undefine C-s that stops terminal. It will be used as forward history search instead
stty stop undef

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# --------------------------------


# LESS coloring. Will guess based on content if can't find lexer
#export LESSOPEN="| pygmentize -gO style=monokai %s"
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

# setup NODE
export N_PREFIX="$HOME/.n"
export PATH=$N_PREFIX/bin:$PATH
export NODE_PATH=$N_PREFIX/bin

# setup NEOVIM
export PATH="$PATH:/opt/nvim-linux64/bin"

## GLOBAL NODE MODULES HAVE TO BE USEDAFTER N SETUP

# github cli completion
[[ -f /usr/bin/gh ]] && eval "$(gh completion -s bash)"

# github copilot cli
# eval "$(github-copilot-cli alias -- "$0")"

# tldr completion
[ -f ~/.tldr-completion.bash ] && source ~/.tldr-completion.bash

# autojump
# if [ -d /usr/share/autojump ]; then
#     . /usr/share/autojump/autojump.sh
# fi
# zoxide instead of autojump

command -v zoxide >/dev/null && eval "$(zoxide init bash)"

# RUST - cargo
if [ -d "$HOME/.cargo/" ]; then
    . "$HOME/.cargo/env"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

. "/home/tooster/.deno/env"
