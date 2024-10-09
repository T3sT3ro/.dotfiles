#!/bin/zsh
# .zshrc - Zsh file loaded on interactive shell sessions.

[[ $PROF -eq 1 ]] && zmodload zsh/zprof

# Zsh options.
setopt extended_glob
setopt histignorealldups sharehistory
setopt autopushd    

# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
# completions directories
COMPLETIONS_DIR="$ZDOTDIR/completions/"

fpath=(
    $ZFUNCDIR
    /usr/share/zsh/site-functions/
    $fpath
    $COMPLETIONS_DIR
)

autoload -Uz $fpath[1]/*(.:t)

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_antidote_plugins

# -----------------------------------------


# Add deno completions to search path
if [[ ":$FPATH:" != *":$COMPLETIONS_DIR:"* ]]; then 
    export FPATH="$COMPLETIONS_DIR:$FPATH"; 
fi

function completionsStaleOrMissing() {
    # if file does not exist
    if [ ! -f "$COMPLETIONS_DIR/_$1" ]; then
        return 0
    fi
    # if file is older than a week
    if [[ $(find "$COMPLETIONS_DIR/_$1" -mtime +7) ]]; then
        return 0
    fi
    return 1
}

# starship
(( $+commands[starship] )) && completionsStaleOrMissing starship && starship completions zsh > "$COMPLETIONS_DIR/_starship"

# just
(( $+commands[just] )) && completionsStaleOrMissing just && just --completions zsh > "$COMPLETIONS_DIR/_just"

# rust
(( $+commands[rustup] )) && completionsStaleOrMissing rustup && rustup completions zsh > "$COMPLETIONS_DIR/_rustup"
(( $+commands[rustup] )) && completionsStaleOrMissing cargo && rustup completions zsh cargo > "$COMPLETIONS_DIR/_cargo"


# -----------------------------------------

# run tips to show banner
tips

# use starship as prompt provider
eval "$(starship init zsh)"

# -----------------------------------------

# Enable vim mode with ESC - for now disabled, because it doesn't play nicely with ALT+.
# bindkey -v

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && . "$HOME/.sdkman/bin/sdkman-init.sh"

# Generated for envman. Do not edit.
[[ -s "$HOME/.config/envman/load.sh" ]] && . "$HOME/.config/envman/load.sh"

. "/home/tooster/.deno/env"

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

# -----------------------------------------
# FZF configuration

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ $PROF -eq 1 ]] && zprof

