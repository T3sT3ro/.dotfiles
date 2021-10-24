# PROMPT settings

REMOTE=$(who am i | awk -F' ' '{printf $5}')
[[ $REMOTE =~ \([-a-zA-Z0-9\.]+\)$ ]] && REMOTE=true || REMOTE=false

function __ttr_prompt {
    # store exit code
    exit=$?
    # After each command, save and reload history
    history -a; history -c; history -r;
    #
    # always start prompt on new line and append indicator if line didn't end with newline
    local curpos
    echo -en "[6n"
    IFS=";" read -sdR -a curpos
    (( curpos[1]!=1 )) && echo -e '[1;7;33m ⌥  [0m'

    #
    # GIT_PS1_DESCRIBE_STYLE
    GIT_PS1_SHOWCOLORHINTS=true
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM='auto'
    
    # last command exit code green if 0 and red otherwise
    local RET_COLOR=$([[ $exit -eq 0 ]] && echo "32" || echo "31")
    local RET_FORMAT=$(printf "%-3s" $exit)
    local INV_OFF="\\[[27m\\]" # deletes reverse
    local DECOR="${INV_OFF}-"
    # legacy terminals look bad with the slant
    # for other terminals: ◣
    # for "special need terminals": -
    # for those, where above triangle is not full height: space pad on the right to ecode
    ! [[ $TERM =~ ^(.*term|rxvt)$ ]] && DECOR="${INV_OFF}◣" && RET_COLOR="7;$RET_COLOR" && RET_FORMAT=" $RET_FORMAT"
    # triangle symbol doesn't occupy full height in JetBrains-Jedi and vscode terminal looking fugly
    if [[ $TERM_PROGRAM =~ vscode ]] || [[ $TERMINAL_EMULATOR =~ .*JetBrains.* ]]; then DECOR=" ${INV_OFF}"; fi
    local USR_COLOR=$([[ $UID -eq 0 ]] && echo 31 || echo 32)
    local HOST_COLOR=$( [[ REMOTE ]] && echo 33 || echo 33 )
    local CHROOT=${debian_chroot:+\[[0;3;34m\]($debian_chroot)\[[23m\]}
    
    local RET="\\[[0;1;${RET_COLOR}m\\]${RET_FORMAT}${DECOR}"
    local USR="\\[[0;1;${USR_COLOR}m\\]\\u@\\[${HOST_COLOR}m\\]\\h"
    local PWD="\\[[0;1;34m\\]\\w\\[[0m\\]"
    local SHEBANG="\\[[0m\\]\\$ "
    local GIT_FORMAT=" \\[[36m\\](%s\\[[36m\\])"
    if [[ $(tput cols) -le 90 ]]; then
        PS1="$RET [\\t] $CHROOT$USR\\[[0m\\] $(__git_ps1 $GIT_FORMAT)\\n\\[\\e[0;1;7m!\\!\\e[27m\\] $PWD\\n$SHEBANG"
    else
        PS1="$RET $CHROOT$USR\\[[0m\\]:$PWD $(__git_ps1 $GIT_FORMAT)$SHEBANG" 
    fi
    return $exit
}

PROMPT_COMMAND="__ttr_prompt"
# IF SOMETHING IS APPENDED AT START, THEN $? WON'T WORK
export PROMPT_COMMAND="$PROMPT_COMMAND"


