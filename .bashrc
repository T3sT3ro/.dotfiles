# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# escape sequences input (for example for colors): <CTRL>+V, <CTRL>+[, [, [code]

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# alias to manage dotfiles.
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# =============================================
# tooster
# aliases and utilities


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
    fi;
}

alias t=_ttr_new_tmux_session
complete -F _ttr_tmux_session_complete t


alias wp="cd ~/workspace"
alias notes="code ~/notes.md"
alias lenny='echo -n "( ͡° ͜ʖ ͡°)" | xclip -sel c'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

#
# =============================================
#


# setup ruby gems PATH
if which ruby >/dev/null && which gem >/dev/null; then
    RUBYPATH="$(ruby -r rubygems -e 'puts Gem.user_dir')"
    export PATH="$RUBYPATH/bin:$PATH"
fi

#setup TheFuck
eval "$(thefuck --alias)"

# setup ANTLR
export CLASSPATH=".:/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH"
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.8-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tooster/.sdkman"
[[ -s "/home/tooster/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tooster/.sdkman/bin/sdkman-init.sh"
