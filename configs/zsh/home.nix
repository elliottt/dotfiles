{ config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;

    autocd = true;

    defaultKeymap = "viins";

    shellAliases = {
      ls = "ls --color=auto";
    };

    initExtra = ''
    AGKOZAK_LEFT_PROMPT_ONLY=1
    AGKOZAK_COLORS_EXIT_STATUS="169"
    AGKOZAK_COLORS_USER_HOST="254"
    AGKOZAK_COLORS_PATH="109"
    AGKOZAK_COLORS_BRANCH_STATUS="244"
    AGKOZAK_PROMPT_DIRTRIM="0"
    '';

    envExtra = ''
    export PATH="$PATH:${config.home.homeDirectory}/.local/bin"
    '';

    # Helpful tip:
    # When computing the `sha256` value, use `nix-prefetch-url` with the github
    # archive url.

    plugins = with pkgs; [
      {
        name = "agkozak-zsh-prompt";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.11.1";
          sha256 = "1rl0bqmflz7c1n6j6n4677x6kscc160s6zd5his8bf1m3idw1rsc";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
    ];

  };

  programs.direnv.enableZshIntegration = true;

  programs.fzf.enableZshIntegration = true;

}
