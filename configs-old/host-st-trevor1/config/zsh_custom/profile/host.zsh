### BEGIN STRIPE
source ~/.stripe_profile
### END STRIPE

### BEGIN HENSON
export PATH="/Users/trevor/stripe/henson/bin:$PATH"
### END HENSON

### BEGIN RBENV
export PATH="/Users/trevor/.rbenv/shims:$PATH"
export PATH="/Users/trevor/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
### END RBENV

### BEGIN PASSWORD VAULT
export PATH="/Users/trevor/stripe/password-vault/bin:$PATH"
### END PASSWORD VAULT

### BEGIN SPACE COMMANDER
export PATH="/Users/trevor/stripe/space-commander/bin:$PATH"
### END SPACE COMMANDER
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Use fzf from homebrew
export FZF_HOME="/usr/local/opt/fzf"

# Pinned for development
export PYENV_VERSION="3.7.3"
