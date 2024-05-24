[[ $PROF -eq 1 ]] && zmodload zsh/zprof

export EDITOR="nvim"
export VISUAL="code"

autoload -Uz promptinit
promptinit -i

HISTSIZE=4000
SAVEHIST=9000
HISTFILE=$ZDOTDIR/.zsh_history
setopt histignorealldups sharehistory

# -----------------------------------------

#dump .compdump files to ohmyzsh/cache
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

COMPLETIONS_DIR="$ZDOTDIR/completions/"
fpath+=(
  "/usr/share/zsh/functions/",
  "/usr/share/zsh/site-functions/",
  "$COMPLETIONS_DIR",
  "$ZSH_CUSTOM/plugins/zsh_completions/src"
)

(( $+commands[starship] )) && starship completions zsh > "$COMPLETIONS_DIR/_starship"
(( $+commands[just] )) && just --completions zsh > "$COMPLETIONS_DIR/_just"

# Use modern completion system
# disabled due to zsh-autocomplete # enabled again due to zsh-autocomplete sucking ass
autoload -Uz compinit 
compinit

# -----------------------------------------

# run tips to show banner
tips

# source oh-my-zsh
source $ZDOTDIR/omz.zsh
# Autocompletion
zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=( 10 )'
# History menu.
zstyle ':autocomplete:history-search-backward:*' list-lines $SAVEHIST

# -----------------------------------------

# Enable vim mode with ESC
bindkey -v

# setup NODE
export N_PREFIX="$HOME/.n"
export SDKMAN_DIR="$HOME/.sdkman"
export NODE_PATH=$N_PREFIX/bin

path+=("/opt/nvim-linux64/bin")
path+=("$N_PREFIX/bin")

export PATH




source ${ZDOTDIR:-$HOME}/plugins.zsh
source ${ZDOTDIR:-$HOME}/functions.zsh
source ${ZDOTDIR:-$HOME}/aliases.zsh

# use starship as prompt provider
eval "$(starship init zsh)"


# RUST - cargo
[[ -d "$HOME/.cargo/" ]] && . "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && . "$HOME/.sdkman/bin/sdkman-init.sh"

# Generated for envman. Do not edit.
[[ -s "$HOME/.config/envman/load.sh" ]] && . "$HOME/.config/envman/load.sh"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tooster/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tooster/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tooster/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tooster/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[[ $PROF -eq 1 ]] && zprof
