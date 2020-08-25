
if [ -d "$HOME/.cabal/bin" ]; then
  export PATH="$HOME/.cabal/bin:$PATH"
fi

use_ghc() {
  export PATH="$HOME/.local/ghc/$1/bin:$PATH"
}

if [ -d "$HOME/.local/ghc/current/bin" ]; then
  use_ghc current
fi
