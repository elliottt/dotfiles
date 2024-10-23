{ config, pkgs, ... }:

{
  imports = [
    ../programs/neovim
    ../programs/tmux
    ../programs/zsh
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/Users/trevor";

  programs.git.userEmail = "trevor@stripe.com";
  programs.gh.settings.http_unix_socket = "/Users/trevor/.stripeproxy";

  # Override some alacritty settings
  programs.alacritty.settings.font.normal.family = "FiraCodeNerdFontMono";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })

    parallel
    hub
    rsync
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.zsh.initExtra = ''
    # From stripe IT department
    export PATH="$HOME/stripe/henson/bin:$PATH"
    export PATH="$PATH:$HOME/stripe/space-commander/bin"
    eval "$(rbenv init -)"
    eval "$(nodenv init -)"
  '';

  home.file = {
    ".config/alacritty/alacritty.toml".text = ''
      [window.padding]
      x = 5
      y = 5

      [font]
      size = 12

      [font.normal]
      family = "FiraCode Nerd Font Mono"
      style = "Regular"
    '';
  };
}
