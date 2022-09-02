
# { This profiles the bashrc
#exec 3>&2 2> >( tee sample.log |
#                  sed -u 's/^.*$/now/' |
#                  date -f - +%s.%N >sample.tim)
#set -x

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

. ~/.bashrc.d/remote
. ~/.bashrc.d/dotfiles
. ~/.bashrc.d/aliases
. ~/.bashrc.d/tmux
. ~/.bashrc.d/prompt
. ~/.bashrc.d/todo

# github cli completion
eval "$(gh completion -s bash)"


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



# tldr completion
[ -f ~/.tldr-completion.bash ] && source ~/.tldr-completion.bash


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


# autojump
# if [ -d /usr/share/autojump ]; then
#     . /usr/share/autojump/autojump.sh
# fi
# zoxide instead of autojump

if ! command -v zoxide &> /dev/null; then
    read -p "Install zoxide?? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        eval "$($HOME/.local/bin/zoxide init bash)"
    fi
else
    eval "$($HOME/.local/bin/zoxide init bash)"
fi

# setup ANTLR
export CLASSPATH=".:/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH"
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

#setup NODE
export N_PREFIX="$HOME/.n"
export PATH=$N_PREFIX/bin:$PATH
export NODE_PATH=$N_PREFIX/bin

# RUST - cargo
if [ -d "$HOME/.cargo/" ]; then
    . "$HOME/.cargo/env"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# THIS PROFILES THE BASHRC }
#set +x
#exec 2>&3 3>&-

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
