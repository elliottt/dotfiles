# prompt customization
ZSH_THEME="agkozak"
AGKOZAK_LEFT_PROMPT_ONLY=1

CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(gitfast git brew vagrant)

source $ZSH/oh-my-zsh.sh

# vim keybindings
bindkey -v

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

if command -v rg > /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
