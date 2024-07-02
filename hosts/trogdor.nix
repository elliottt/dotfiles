{ config, pkgs, ... }:

let

  cargo-component = import ../packages/cargo-component.nix { inherit pkgs; };
  cargo-nextest = import ../packages/cargo-nextest.nix { inherit pkgs; };
  cargo-vet = import ../packages/cargo-vet.nix { inherit pkgs; };
  cbindgen = import ../packages/cbindgen.nix { inherit pkgs; };
  viceroy = import ../packages/viceroy.nix { inherit pkgs; };
  wasm-tools = import ../packages/wasm-tools.nix { inherit pkgs; };
  wac-cli = import ../packages/wac-cli.nix { inherit pkgs; };
  wit-bindgen = import ../packages/wit-bindgen.nix { inherit pkgs; };

in {

  imports = [
    ../programs/neovim
    ../programs/rust
    ../programs/tmux
    ../programs/zsh
    ../programs/gdb
    ../programs/serve-profiles
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
    pkgs.fd
    pkgs.whois
    pkgs.age
    pkgs.kbs2
    pkgs.pass
    pkgs.docker-credential-helpers

    cargo-component
    cargo-nextest
    cargo-vet
    cbindgen
    viceroy
    wac-cli
    wasm-tools
    wit-bindgen
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
