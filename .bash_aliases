alias cd..='cd ..'
alias ..='cd ..'
alias ~='cd ~'
alias short='USERDISPLAY=$SHORTNAME;HOSTDISPLAY=$SHORTHOST'
alias long='USERDISPLAY=$LONGNAME;HOSTDISPLAY=$LONGHOST'
alias bat='batcat'


if [ -f ~/.ascii ]; then
    . ~/.ascii
fi

GENERATE_ASCII(){
	arand=$[$RANDOM % ${#ascii[@]}]
	chosen_ascii=${ascii[$arand]}
	
	colors[0]="\033[01m\033[01;31m" # red
	colors[1]="\033[01m\033[01;32m" # green
	colors[2]="\033[01m\033[01;33m" # yellow
	colors[3]="\033[01m\033[01;34m" # blue
	colors[4]="\033[01m\033[01;35m" # magenta
	colors[5]="\033[01m\033[01;36m" # cyan
	
	crand=$[$RANDOM % ${#colors[@]}]
	chosen_color=${colors[$crand]}


	printf "${chosen_color}${chosen_ascii}\033[0m"
}

alias neofetch="neofetch --ascii \"$(GENERATE_ASCII)\""
