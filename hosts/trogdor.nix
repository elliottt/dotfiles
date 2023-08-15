{ config, pkgs, ... }:

let

  cargo-component = pkgs.rustPlatform.buildRustPackage rec {
    pname = "cargo-component";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "bytecodealliance";
      repo = pname;
      rev = "d14cef65719d0d186218d1dfe5f04bbbf295dc80";
      sha256 = "162qr3brrb1flr5fras1lak9i59zyalmj28pvg276dbrf6hrnmkl";
    };

    nativeBuildInputs = [
      pkgs.pkg-config
      pkgs.openssl.dev
      pkgs.zlib.dev
    ];

    buildInputs = [
      pkgs.openssl
      pkgs.zlib
    ];

    doCheck = false;

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "warg-api-0.1.0" = "sha256-A5FQ/nbuzV8ockV6vOMKUEoJKeaId3oyZU1QeNpd1Zc=";
      };
    };
  };

  cargo-vet = pkgs.rustPlatform.buildRustPackage rec {
    pname = "cargo-vet";
    version = "0.8.0";

    src = pkgs.fetchFromGitHub {
      owner = "mozilla";
      repo = "cargo-vet";
      rev = "8c8b6d7a5237544c613de616a031586587f49a42";
      sha256 = "sha256-WBoPDF69O4jhBvsETnFyGCcUGcaVbsRwUfIJoRt1mk8=";
    };

    doCheck = false;

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
  };

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
