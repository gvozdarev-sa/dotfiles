if [ -f /etc/profile.d/bash-completion.sh ]; then
	    source /etc/profile.d/bash-completion.sh
fi

xhost +local:root > /dev/null 2>&1
export TERM='xterm-256color'


complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# setup color variables
color_is_on=
color_red=
color_green=
color_yellow=
color_blue=
color_white=
color_gray=
color_bg_red=
color_off=
color_user=
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_is_on=true
    color_red="\[$(/usr/bin/tput setaf 1)\]"
    color_green="\[$(/usr/bin/tput setaf 2)\]"
    color_yellow="\[$(/usr/bin/tput setaf 3)\]"
    color_blue="\[$(/usr/bin/tput setaf 6)\]"
    color_white="\[$(/usr/bin/tput setaf 7)\]"
    color_gray="\[$(/usr/bin/tput setaf 8)\]"
    color_off="\[$(/usr/bin/tput sgr0)\]"

    color_error="$(/usr/bin/tput setab 1)$(/usr/bin/tput setaf 7)"
    color_error_off="$(/usr/bin/tput sgr0)"

    # set user color
    case `id -u` in
        0) color_user=$color_red ;;
        *) color_user=$color_green ;;
    esac
fi

function timer_start {
    timer=${timer:-$SECONDS}
}

function timer_stop {
    timer_show=$(($SECONDS - $timer))
    unset timer
}

trap 'timer_start' DEBUG

# some kind of optimization - check if git installed only on config load
PS1_GIT_BIN=$(which git 2>/dev/null)

function prompt_command {
    local CODE=$?
    timer_stop;
    local PS1_GIT=
    local PS1_VENV=
    local GIT_BRANCH=
    local GIT_DIRTY=
    local PWDNAME=$PWD

    # beautify working directory name
    if [[ "${HOME}" == "${PWD}" ]]; then
        PWDNAME="~"
    elif [[ "${HOME}" == "${PWD:0:${#HOME}}" ]]; then
        PWDNAME="~${PWD:${#HOME}}"
    fi

    # parse git status and get git variables
    if [[ ! -z $PS1_GIT_BIN ]]; then
        # check we are in git repo
        local CUR_DIR=$PWD
        while [[ ! -d "${CUR_DIR}/.git" ]] && [[ ! "${CUR_DIR}" == "/" ]] && [[ ! "${CUR_DIR}" == "~" ]] && [[ ! "${CUR_DIR}" == "" ]]; do CUR_DIR=${CUR_DIR%/*}; done
        if [[ -d "${CUR_DIR}/.git" ]]; then
            # 'git repo for dotfiles' fix: show git status only in home dir and other git repos
            if [[ "${CUR_DIR}" != "${HOME}" ]] || [[ "${PWD}" == "${HOME}" ]]; then
                # get git branch
                GIT_BRANCH=$($PS1_GIT_BIN symbolic-ref HEAD 2>/dev/null)
                if [[ ! -z $GIT_BRANCH ]]; then
                    GIT_BRANCH=${GIT_BRANCH#refs/heads/}

                    # get git status
                    local GIT_STATUS=$($PS1_GIT_BIN status --porcelain 2>/dev/null)
                    [[ -n $GIT_STATUS ]] && GIT_DIRTY=1
                fi
            fi
        fi
    fi

    # build b/w prompt for git and virtual env
    [[ ! -z $GIT_BRANCH ]] && PS1_GIT=" (git: ${GIT_BRANCH})"
    [[ ! -z $VIRTUAL_ENV ]] && PS1_VENV=" (venv: ${VIRTUAL_ENV#$WORKON_HOME})"

    # calculate prompt length
    local PS1_length=$((${#USER}+${#HOSTNAME}+${#PWDNAME}+${#PS1_GIT}+${#PS1_VENV}+3))
    local FILL=

    # if length is greater, than terminal width
    if [[ $PS1_length -gt $COLUMNS ]]; then
        # strip working directory name
        PWDNAME="...${PWDNAME:$(($PS1_length-$COLUMNS+3))}"
    else
        # else calculate fillsize
        local fillsize=$(($COLUMNS-$PS1_length))
        FILL=$color_white
        while [[ $fillsize -gt 0 ]]; do FILL="${FILL}─"; fillsize=$(($fillsize-1)); done
        FILL="${FILL}${color_off}"
    fi

    if $color_is_on; then
        # build git status for prompt
        if [[ ! -z $GIT_BRANCH ]]; then
            if [[ -z $GIT_DIRTY ]]; then
                PS1_GIT=" (git: ${color_green}${GIT_BRANCH}${color_off})"
            else
                PS1_GIT=" (git: ${color_red}${GIT_BRANCH}${color_off})"
            fi
        fi

        # build python venv status for prompt
        [[ ! -z $VIRTUAL_ENV ]] && PS1_VENV=" (venv: ${color_blue}${VIRTUAL_ENV#$WORKON_HOME}${color_off})"
    fi

    if $color_is_on; then
        if [[ $CODE != 0 ]]; then
            CODE=${color_error}$(printf %d ${CODE})${color_off}
        else
            CODE=${color_white}$(printf %d ${CODE})${color_off}
        fi
    fi

    # set new color prompt
    PS1="#${CODE}, ${timer_show} secs\n${color_user}${USER}${color_off}@${color_yellow}${HOSTNAME}${color_off}:${color_white}${PWDNAME}${color_off}${PS1_GIT}${PS1_VENV} ${FILL}\n# "

    # get cursor position and add new line if we're not in first column
    # cool'n'dirty trick (http://stackoverflow.com/a/2575525/1164595)
    # XXX FIXME: this hack broke ssh =(
#	exec < /dev/tty
#	local OLDSTTY=$(stty -g)
#	stty raw -echo min 0
#	echo -en "\033[6n" > /dev/tty && read -sdR CURPOS
#	stty $OLDSTTY
    echo -en "\033[6n" && read -sdR CURPOS
    [[ ${CURPOS##*;} -gt 1 ]] && echo "${color_error}↵${color_error_off}"

    # set title
    echo -ne "\033]0;${USER}@${HOSTNAME}:${PWDNAME}"; echo -ne "\007"
}

# set prompt command (title update and color prompt)
PROMPT_COMMAND=prompt_command
# set new b/w prompt (will be overwritten in 'prompt_command' later for color prompt)
PS1='\u@\h:\w\$ '

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# vim stuff
export EDITOR=vim
export VISUAL=vim
alias vi=vim

