#!/bin/bash

# this tells anyone logged into machine that he is logged via SSH

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || (pstree -s $$ | grep sshd ); then
    SESSION_TYPE=remote/ssh
    # many other tests omitted
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) SESSION_TYPE=remote/ssh;;
    esac
fi
export SESSION_TYPE

# remap prefix-r to reload tmux conf
if [[ $TMUX && $SESSION_TYPE = remote/ssh ]]; then
    tmux unbind C-a #if it persisted somehow
    tmux set -g prefix C-b
    tmux bind C-b send-prefix
    tmux set status-style bg=blue,fg=white
    tmux set pane-active-border-style fg=yellow,bg=blue
    tmux refresh-client -S
else
    tmux unbind C-b
    tmux set -g prefix C-a
    tmux bind C-a send-prefix
    tmux refresh-client -S
fi

#REMOTE=$(who am i | awk -F' ' '{printf $5}')
#[[ $REMOTE =~ \([-a-zA-Z0-9\.]+\)$ ]] && REMOTE=true || REMOTE=false

