# prompt customization
ZSH_THEME="agkozak"
AGKOZAK_LEFT_PROMPT_ONLY=1

CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git brew)

# vim keybindings
bindkey -v

source $ZSH/oh-my-zsh.sh

# handy scp wrapper for avoiding the weird local-to-local behavior
scp() {
  if grep -q : <(printf %s "$@")
  then
    command scp "$@"
  else
    echo If you really want to use scp to do cp"'"s job, type '`command !!`'.
    return 1
  fi
}

export EDITOR='nvim'

export PATH="$PATH:$HOME/.cargo/bin"
