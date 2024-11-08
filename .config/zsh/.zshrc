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
autoload -U select-word-style
select-word-style bash

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_antidote_plugins

# -----------------------------------------

function refreshCompletion() {
  # in red
  # echo $(tput setaf 1)Refreshing $1 completions...$(tput sgr0)
  # if command doesn't exist
  (($+commands[$1])) || return 0

  # if file does not exist
  if [ ! -f "$COMPLETIONS_DIR/_$1" ]; then
    return 0
  fi
  # if file is older than a week
  if [[ $(find "$COMPLETIONS_DIR/_$1" -mtime +7) ]]; then
    return 0
  fi

  # if COMPLETE_FOR was specified, use it (e.g. COMPLETE_FOR=cargo refreshCompletion rustup completions zsh cargo)
  #
  $@ >"$COMPLETIONS_DIR/${COMPLETE_FOR:-_${1}}"

  return 1
}

# -----------------------------------------
# starship
refreshCompletion starship completions zsh

refreshCompletion just --completions zsh

# rust
COMPLETE_FOR=rustup refreshCompletion rustup completions zsh
COMPLETE_FOR=cargo refreshCompletion rustup completions zsh cargo

# ripgrep
# COMPLETE_FOR=rg rg --generate=complete-zsh

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

[[ -s "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="$HOME/miniconda3/bin:$PATH"
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
