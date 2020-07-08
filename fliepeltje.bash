SCM_THEME_PROMPT_PREFIX="${normal}[${bold_yellow}"
SCM_THEME_PROMPT_SUFFIX="]${normal}"

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"

#Mysql Prompt
export MYSQL_PS1="(\u@\h) [\d]> "

case $TERM in
        xterm*)
        TITLEBAR="\[\033]0;\w\007\]"
        ;;
        *)
        TITLEBAR=""
        ;;
esac

PS3=">> "


is_vim_shell() {
        if [ ! -z "$VIMRUNTIME" ]
        then
                echo "[${cyan}vim shell${normal}]"
        fi
}


chroot(){
    if [ -n "$debian_chroot" ]
    then
        my_ps_chroot="${bold_cyan}$debian_chroot${normal}";
        echo "($my_ps_chroot)";
    fi
    }

# pyenv wrapper
my_ve(){
    if [ -n "$CONDA_DEFAULT_ENV" ]
    then
        my_ps_ve="${bold_purple}${CONDA_DEFAULT_ENV}${normal}";
        echo "($my_ps_ve)";
    elif [ -n "$PYENV_VERSION" ]
    then
        my_ps_ve="${bold_cyan}$ve${normal}";
        echo "($my_ps_ve)";
    fi
    echo "";
    }

prompt() {

    my_ps_host="${green}\h${normal}";
    my_ps_host_root="${green}\h${normal}";

    my_ps_user="${bold_green}\u${normal}"
    my_ps_root="${bold_red}\u${normal}";
    identity="$my_ps_user${bold_green} @ ${normal}$my_ps_host"
    scm="$(scm_prompt_info)"
    if [ -n "$PYENV_VERSION" ]
    then
        ve=`basename "$PYENV_VERSION"`;
    fi

    case "`id -u`" in
        0) PS1="${TITLEBAR}┌─$(my_ve)$(chroot)[$identity][$scm]
> "
        ;;
        *) PS1="${TITLEBAR}┌─$(my_ve)$(chroot)[$identity][${bold_purple}\w${normal}]$scm
> "
        ;;
    esac
}

PS2="▪ "

# vi mode
set -o vi
bind 'set vi-ins-mode-string "└+"'
bind 'set vi-cmd-mode-string "└─"'
bind 'set show-mode-in-prompt on'
bind '"jj":vi-movement-mode'
VIMRUNTIME='true'

safe_append_prompt_command prompt
