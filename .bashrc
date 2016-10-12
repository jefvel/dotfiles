# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
		*i*) ;;
*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
		debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
		xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
		if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
				# We have color support; assume it's compliant with Ecma-48
				# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
				# a case would tend to support setf rather than setaf.)
				color_prompt=yes
		else
				color_prompt=
		fi
fi

if [ "$color_prompt" = yes ]; then
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
		xterm*|rxvt*)
				PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
				;;
		*)
				;;
esac

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
ORANGE=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
LBLUE=$(tput setaf 6)
WHITE=$(tput setaf 7)
NOCOLOR=$(tput sgr0)

#LBLUE=$'\e[36;50m'
#PURPLE=$'\e[35;50m'
#GREEN=$'\e[32;50m'
#ORANGE=$'\e[33;50m'
#YELLOW=$'\e[37;50m'
#PINK=$'\e[31;50m'


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
		test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
		alias ls='ls --color=auto'
		alias dir='dir --color=auto'
		alias vdir='vdir --color=auto'
		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
		. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
		if [ -f /usr/share/bash-completion/bash_completion ]; then
				. /usr/share/bash-completion/bash_completion
		elif [ -f /etc/bash_completion ]; then
				. /etc/bash_completion
		fi
fi

export PATH=${PATH}:/home/jefvel/adt-bundle-linux/sdk/platform-tools:/home/jefvel/.composer/vendor/bin:/usr/local/bin

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo -e $LBLUE"Initializing new SSH agent...$NOCOLOR"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add ~/.ssh/pallkars
    echo -e "$(tput setaf 2)$(toilet -f smblock Success!)"$NOCOLOR
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi


#source ~/git/bash-git-prompt/gitprompt.sh

alias vallegrinne='valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes'

alias vi=vim
export EDITOR=vim

alias installera="sudo pacman -S"
alias rrtorrent="dtach -a /tmp/rtorrent.dtach"
alias starttorrent="dtach -n /tmp/rtorrent.dtach rtorrent"
alias colors="~/scripts/colors.sh"
alias xclip="xclip -selection c"
alias sleepu="sudo pm-suspend"
alias hist="history | grep "
alias notify-send="notify"


alias pallkars='ssh pallkars.net -p 12345'
alias rootpowered="ssh rootpowered.nl -p420"

export QT_STYLE_OVERRIDE=gtk

debug() {
  echo -n $'\e[0m';
}

trap debug DEBUG

# This bit changes the prompt when you're in a Git repo.
function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local gitcolour="nothing to commit:$YELLOW"
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local gitcolour="untracked:$PINK"
        else
            local gitcolour="branch:$LBLUE"
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != master || branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n "$gitcolour $branch"
    fi
}

# Colour your prompt
function _prompt_command() {
    #PS1='\[$RED\]\u\[$LBLUE\]:\[$GREEN\]\w \[$LBLUE\]$ \[$NOCOLOR\]'
    PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
}

export PROMPT_COMMAND=_prompt_command

