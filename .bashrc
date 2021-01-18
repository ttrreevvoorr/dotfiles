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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
LONGNAME="$USER"
SHORTNAME=${LONGNAME:0:4}
USERDISPLAY="${LONGNAME}"

LONGHOST="${HOSTNAME}"
SHORTHOST="${HOSTNAME:0:4}"
HOSTDISPLAY="${LONGHOST}"


PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]$USERDISPLAY\[\033[01;31m\]@\[\033[01;34m\]$HOSTDISPLAY\[\033[00m\]:\[\033[01;34m\]\W \[\033[01;33m\]⚙ \[\[\033[00m\]'


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


greeting () {
# http://patorjk.com/software/taag-v1/
# https://colordesigner.io/gradient-generator
if $GREETME; then
	echo -e "\033[38;2;254;039;064m dP\"\"Yb \033[0;00m \033[38;2;000;146;254m8888P 88   88 88     888888 88  dP\"Yb     db    88\"\"Yb \033[0;00m"
	echo -e "\033[38;2;255;096;049mdP PY Yb \033[0;00m\033[38;2;000;180;255m  dP  88   88 88     88__   88 dP   Yb   dPYb   88__dP    \033[0;00m"
	echo -e "\033[38;2;255;138;039mYb boodP \033[0;00m\033[38;2;000;204;215m dP   Y8   8P 88  .o 88\"\"   88 Yb b dP  dP__Yb  88\"Yb      \033[0;00m"
	echo -e "\033[38;2;255;176;044m Ybooo   \033[0;00m\033[38;2;000;204;215md8888 \`YbodP' 88ood8 88     88  \`\"YoYo dP\"\"\"\"Yb 88  Yb \033[0;00m\n"

#"\033[38;2;000;146;254m dP\"\"Yb  \033[0;00m  
#"\033[38;2;000;146;254mdP PY Yb \033[0;00m 
#"\033[38;2;000;146;254mYb boodP \033[0;00m
#"\033[38;2;000;146;254m Ybooo   \033[0;00m

fi
}

greeting


