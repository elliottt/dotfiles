
export PATH="$HOME/.cabal/bin:$PATH"

use_ghc() {
  export PATH="$HOME/.local/ghc/$1/bin:$PATH"
}

use_ghc current
