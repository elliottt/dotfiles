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

    envExtra = ''
    export PATH="$PATH:${config.home.homeDirectory}/.local/bin"
    '';
  };

  # If direnv is enabled, make sure that zsh integration is present.
  programs.direnv.enableZshIntegration = true;

  # Enable fzf integration when zsh is managed by home-manager
  programs.fzf.enableZshIntegration = true;
}
