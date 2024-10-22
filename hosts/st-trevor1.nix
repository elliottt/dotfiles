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

  # Override some alacritty settings
  programs.alacritty.settings.font.normal.family = "FiraCodeNerdFontMono";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
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
    ### BEGIN STRIPE
    # All Stripe related shell configuration
    # is at ~/.stripe/shellinit/zshrc and is
    # persistently managed by Chef. You shouldn't
    # remove this unless you don't want to load
    # Stripe specific shell configurations.
    #
    # Feel free to add your customizations in this
    # file (~/.zshrc) after the Stripe config
    # is sourced.
    if [[ -f ~/.stripe/shellinit/zshrc ]]; then
      source ~/.stripe/shellinit/zshrc
    fi
    ### END STRIPE
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
