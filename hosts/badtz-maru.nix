{ config, pkgs, ... }:

{

  imports = [
    ../programs/neovim
    ../programs/rust
    ../programs/tmux
    ../programs/zsh
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  targets.genericLinux.enable = true;

  programs.git.userEmail = "awesomelyawesome@gmail.com";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.p7zip

    (pkgs.binutils // { meta.priority = 6; })
    (pkgs.gcc // { meta.priority = 8; })

    pkgs.clang_16
    pkgs.clang-tools_16
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  services.ssh-agent.enable = true;
}
