#!/bin/bash
# PROMPT settings

# moved to using starhip instead of my custom, breaking prompt
eval "$(starship init bash)"
return
# below won't be run

. ~/.bashrc.d/promptrc
# debians
[ -f /usr/lib/git-core/git-sh-prompt ] && source /usr/lib/git-core/git-sh-prompt
# centos, fedora (yum)
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && source /usr/share/git-core/contrib/completion/git-prompt.sh

###
# Get the current terminal column value.
#
# From https://stackoverflow.com/a/2575525/549363.
###
__ttr_get_terminal_column() {
  exec < /dev/tty
  local oldstty=$(stty -g)
  stty raw -echo min 0
  echo -en "\033[6n" > /dev/tty
  local pos
  IFS=';' read -r -d R -a pos
  stty $oldstty
  echo "$((${pos[1]} - 1))"
}

__term_row() {
    local COL
    local ROW
    IFS=';' read -sdR -p $'\E[6n' ROW COL
    echo "${ROW#*[}"
}

__term_col() {
    local COL
    local ROW
    IFS=';' read -sdR -p $'\E[6n' ROW COL
    echo "${COL}"
}


PROMPT_MULTILINE=90
PROMPT_HISTNUM=true
PROMPT_MULTILINE_DIRTRIM=
PROMPT_INLINE_DIRTRIM=

if [ -f $HOME/.promptrc ];then source $HOME/.promptrc; fi;

function __ttr_prompt {
    # store exit code
    local exit=$?
    local success
    [[ $exit -eq 0 ]] && success=true || success=false
    # After each command, save and reload history
    # this helps in preserving history across panes
    history -a; history -c; history -r;
    #
    # always start prompt on new line and append indicator if line didn't end with newline
    #local curpos
    #echo -en "[6n"
    #IFS=";" read -sdR -a curpos
    #(( curpos[1]!=1 )) && echo -e '[1;7;33m ⌥  [0m'
    #if [ "$(__ttr_get_terminal_column)" != 0 ]; then
#    if [ "$(__term_col)" != 1 ]; then
#        EOL_FIXER='[1;7;33m ⌥  [0m\n'
#    fi

    #
    # GIT_PS1_DESCRIBE_STYLE
    GIT_PS1_SHOWCOLORHINTS=true
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM='auto'
    
    # last command exit code green if 0 and red otherwise
    local RST="\\[[0m\\]"
    local RET_COLOR=$([[ $exit -eq 0 ]] && echo "32" || echo "31")
    local RET_FORMAT=$(printf "%-3s" $exit)
    local INV="\\[[7m\\]"
    local INV_OFF="\\[[27m\\]" # deletes reverse
    local DECOR="${INV_OFF}-"
    local HIST_COLOR="\\[[0;2;7;$RET_COLOR;107m\\]"

    # legacy terminals look bad with the slant
    # for other terminals: ◣
    # for "special need terminals": -
    # for those, where above triangle is not full height: space pad on the right to ecode
    if ! [[ $TERM =~ ^(.*term|rxvt)$ ]]; then
        DECOR="${INV_OFF}◣"
        RET_COLOR="7;$RET_COLOR"
        RET_FORMAT=" $RET_FORMAT"
    else
        RET_FORMAT="$RET_FORMAT   "
        HIST_COLOR="\\[[0;7;39m\\]"
    fi
    # triangle symbol doesn't occupy full height in JetBrains-Jedi and vscode terminal looking fugly
    if [[ $TERM_PROGRAM =~ vscode ]] || [[ $TERMINAL_EMULATOR =~ .*JetBrains.* ]]; then 
        DECOR=" ${INV_OFF}"; 
        HIST_COLOR="\\[[0;7;39m\\]"
    fi
    local USR_COLOR=$( [[ $UID -eq 0 ]] && echo 31 || echo 32 )
    local HOST_COLOR=$( [[ $SESSION_TYPE =~ remote/ssh ]] && echo 33 || echo 32 )
    local CHROOT=${debian_chroot:+\[[0;3;34m\]($debian_chroot)\[[23m\]}
    
    local RET="\\[[0;1;${RET_COLOR}m\\]${RET_FORMAT}${DECOR}"
    local USR="\\[[0;1;${USR_COLOR}m\\]\\u\\[[${HOST_COLOR}m\\]@\\h"
    local PWD_COLOR='\[[0;1;34m\]'
    local SHEBANG='\[[0m\]\$'
    # TODO: fix CHROOT    

    # how __git_ps1 works can be found at /usr/lib/git-core/git-sh-prompt
    # basically first arg is prefix, second is suffix third is format
    if [[ $PROMPT_MULTILINE = always || $(tput cols) -le $PROMPT_MULTILINE ]]; then # make short prompts multiline
        PROMPT_DIRTRIM=$PROMPT_MULTILINE_DIRTRIM
        # HISTFMT prints first a colored box of proper width, then histnum from start, then continues after box
        local HISTFMT="$HIST_COLOR     \\[\r!\!\r$(tput cuf 5)\\]"
        local GIT_FORMAT='\[[36m\]╰(%s\[[36m\])'
        __git_ps1 "${EOL_FIXER}${RET} [\\t] ${CHROOT}${USR}${RST}\\n${HISTFMT}${PWD_COLOR} \\w\\n${RST}" " $SHEBANG " "$GIT_FORMAT"
    else
        PROMPT_DIRTRIM=$PROMPT_INLINE_DIRTRIM
        local HISTFMT="$HIST_COLOR      \\[\r!\\!\r$(tput cuf 6)\\]"
        local GIT_FORMAT='\[[36m\](%s\[[36m\])'
        if [[ $PROMPT_HISTNUM == true ]]; then RET="${HISTFMT}${RST}${RET}"; fi
        __git_ps1 "${EOL_FIXER}${RET} ${CHROOT}${USR}${RST}:${PWD_COLOR}\\w${RST}" " $SHEBANG " " $GIT_FORMAT"
    fi
}

# IF SOMETHING IS APPENDED AT START, THEN $? WON'T WORK
export PROMPT_COMMAND=__ttr_prompt
