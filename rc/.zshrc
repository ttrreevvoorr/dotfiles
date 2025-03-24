autoload -U colors && colors

export TERM='xterm-256color'
export COLORTERM="truecolor"

LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
export CLICOLOR=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  

# ~/.zshrc

# PS1
PS1="%{$fg[green]%}%n%{$reset_color%}%{$fg[white]%}:%{$fg[cyan]%}%2d %{$fg[red]%}%$➜ %{$reset_color%}% "

# Function to change the PS1 prompt
short() {
  PS1="%{$fg[cyan]%}%1d %{$fg[red]%}%$➜ %{$reset_color%}% "
}

source $HOME/.zsh_aliases
source $HOME/.zsh_env

# NVM config
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

# pnpm
export PNPM_HOME="/Users/taustin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pnpm end
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_FEATURE_PNPM=1

export GPG_TTY=$(tty)

