autoload -U colors && colors

LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
export CLICOLOR=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  


# ~/.zshrc

# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}' | cut -c1-9)
  if [[ $branch == "" ]];
  then
    :
  else
    echo '('$branch') '
  fi
}

# Temp PS1
# PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$fg[white]%}:%{$fg[cyan]%}%1d %{$fg[magenta]%}% ♥ %{$reset_color%}% "
PS1="%{$fg[green]%}%n%{$reset_color%}%{$fg[white]%}:%{$fg[cyan]%}%2d %{$fg[yellow]%}$(git_branch_name)%{$fg[red]%}%$➜ %{$reset_color%}% "

# Function to change the PS1 prompt
short() {
  PS1="%{$fg[cyan]%}%1d %{$fg[yellow]%}$(git_branch_name)%{$fg[red]%}%$➜ %{$reset_color%}% "
}

# Aliases
alias ..="cd .."

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias python='python3'
alias zz='source ~/.zshrc'

alias rmswp='rm ~/.local/state/nvim/swap/*'

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
