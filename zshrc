# Path to your oh-my-zsh configuration.
ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.config/zsh_custom"

# prompt customization
ZSH_THEME="agkozak"
AGKOZAK_LEFT_PROMPT_ONLY=1

CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(gitfast git brew vagrant)

source $ZSH/oh-my-zsh.sh

# special key bindings
bindkey -e
bindkey "^f" forward-word
bindkey "^b" backward-word

# ghc management
use_ghc() {
  export PATH=$HOME/local/ghc/$1/bin:$PATH
}

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
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
