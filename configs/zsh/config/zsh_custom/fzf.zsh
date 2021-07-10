
# Fall back on using fzf from the vim plugin if FZF_HOME wasn't set by
# host-specific config.
if [ -z "$FZF_HOME" ]; then
  export FZF_HOME="$HOME/.local/share/nvim/site/pack/packer/start/fzf"
fi

if [ -d "$FZF_HOME" ]; then
  if ! command -v fzf >/dev/null; then
    export PATH="$FZF_HOME/bin:$PATH"
  fi

  export FZF_DEFAULT_COMMAND="rg --files"
  export FZF_CTRL_T_COMMAND="rg --files"

  export FZF_DEFAULT_OPTS="--layout=reverse"
fi
