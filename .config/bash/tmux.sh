#!/bin/bash

# tab completion to attach to tmux session via `t [name]`
function t_complete {
    SESSIONS=$(tmux ls)
    if [[ $? ]]; then # if the server is online
        COMPREPLY=($(compgen -W "$(tmux ls -F '#{session_name}')" "${COMP_WORDS[1]}"))
    fi;
}

# intended usage:
# t -> if not alive -> resurrect and attach using "tmux"
#   -> if alive -> attach to latest
# t <session> -> if not alive -> resurrect, with session
    #             -> if alive -> attach to named session
function t() {
    SESSIONS=$(tmux list-session 2>/dev/null)
    if [ -n "$1" ]; then
        tmux a -t "$1"
    else
        tmux a 
    fi;
}


export -f t

# tmux aliases
alias ta='tmux attach -t'
alias ts='tmux switch -t'
# alias tn=_ttr_new_tmux_session
# alias t='tmux attach || _ttr_new_tmux_session'
alias tl='tmux ls'

complete -F t_complete t
