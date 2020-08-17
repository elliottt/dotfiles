if command -v fzf > /dev/null; then
  export FZF_CTRL_T_COMMAND="rg --files"
  export FZF_DEFAULT_COMMAND="rg --files"
fi
