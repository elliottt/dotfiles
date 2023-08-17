{ config, pkgs, ... }:

let

  cargo-component = import ../packages/cargo-component.nix { inherit pkgs; };
  cargo-vet = import ../packages/cargo-vet.nix { inherit pkgs; };
  wasm-tools = import ../packages/wasm-tools.nix { inherit pkgs; };

in {

  imports = [
    ../configs/base/home.nix
    ../configs/neovim/home.nix
    ../configs/rust.nix
    ../configs/tmux/home.nix
    ../configs/zsh/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  programs.git.userEmail = "telliott@fastly.com";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.bmake
    pkgs.cmake
    pkgs.valgrind
    pkgs.binaryen
    pkgs.yarn
    pkgs.qemu
    pkgs.creduce

    cargo-component
    cargo-vet
    wasm-tools
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
