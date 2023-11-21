{ config, pkgs, ... }:

let
  nixGLWrap = import ../lib/nixgl.nix { inherit pkgs; };
in {
  imports = [
    ../programs/alacritty.nix
    ../programs/base/home.nix
    ../programs/kitty/home.nix
    ../programs/neovim
    ../programs/rust.nix
    ../programs/tmux/home.nix
    ../programs/zsh/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  programs.git.userEmail = "telliott@fastly.com";

  # Override the alacritty package to use the nixGL wrapped version
  programs.alacritty.package = nixGLWrap "alacritty" pkgs.alacritty;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.bmake
    pkgs.cmake
    pkgs.valgrind
    pkgs.binaryen
    pkgs.yarn

    (nixGLWrap "wezterm" pkgs.wezterm)
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
