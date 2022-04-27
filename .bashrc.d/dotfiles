#!/bin/bash

# alias to manage dotfiles.
function dotfiles {
    /usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME "$@"
}
if [ -f /usr/share/bash-completion/completions/git ]; then
    source /usr/share/bash-completion/completions/git
    __git_complete dotfiles __git_main
fi
