{ config, pkgs, ... }:

{

  programs.zsh = {
    enable = true;

    autocd = true;

    defaultKeymap = "viins";

    enableCompletion = true;

    # Convenience aliases from oh-my-zsh
    shellGlobalAliases = {
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
      "......" = "../../../../..";
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
          rev = "v3.11.3";
          sha256 = "sha256-YBqFA/DK2K1effniwjPSe5VMx9tZGbmxyJp92TiingU=";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
    ];

  };

  # If direnv is enabled, make sure that zsh integration is present.
  programs.direnv.enableZshIntegration = true;

  # Enable fzf integration when zsh is managed by home-manager
  programs.fzf.enableZshIntegration = true;

}
