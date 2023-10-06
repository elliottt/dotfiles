{ config, pkgs, ... }:

let

  cargo-component = import ../packages/cargo-component.nix { inherit pkgs; };
  cargo-fuzz = import ../packages/cargo-fuzz.nix { inherit pkgs; };
  cargo-vet = import ../packages/cargo-vet.nix { inherit pkgs; };
  cbindgen = import ../packages/cbindgen.nix { inherit pkgs; };
  viceroy = import ../packages/viceroy.nix { inherit pkgs; };
  wasi-tools = import ../packages/wasi-tools.nix { inherit pkgs; };
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
    pkgs.openssh

    cargo-component
    cargo-fuzz
    cargo-vet
    cbindgen
    viceroy
    wasi-tools
    wasm-tools
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
