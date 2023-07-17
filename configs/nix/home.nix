{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.cmake
    pkgs.exa
    pkgs.gh
    pkgs.git
    pkgs.hyperfine
    pkgs.neovim
    pkgs.ripgrep
    pkgs.valgrind
    pkgs.fzf
    pkgs.tmux

    pkgs.openssl

    (pkgs.binutils // { meta.priority = 6; })
    (pkgs.gcc // { meta.priority = 8; })

    pkgs.llvmPackages_16.clang
    pkgs.clang-tools_16
    pkgs.mold

    pkgs.rust-analyzer

    pkgs.binaryen
    pkgs.yarn
    pkgs.bmake
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = 'clang'
    rustflags = ["-C", "link_arg=--ld-path=/home/trevor/.nix-profile/bin/mold"]

    [target.aarch64-unknown-linux-gnu]
    linker = 'aarch64-linux-gnu-gcc'
    runner = 'qemu-aarch64 -L /usr/aarch64-linux-gnu -E LD_LIBRARY_PATH=/usr/aarch64-linux-gnu/lib -E WASMTIME_TEST_NO_HOG_MEMORY=1'

    [target.riscv64gc-unknown-linux-gnu]
    linker = 'riscv64-linux-gnu-gcc'
    runner = 'qemu-riscv64 -L /usr/riscv64-linux-gnu -E LD_LIBRARY_PATH=/usr/riscv64-linux-gnu/lib -E WASMTIME_TEST_NO_HOG_MEMORY=1'

    [target.s390x-unknown-linux-gnu]
    linker = 's390x-linux-gnu-gcc'
    runner = 'qemu-s390x -L /usr/s390x-linux-gnu -E LD_LIBRARY_PATH=/usr/s390x-linux-gnu/lib -E WASMTIME_TEST_NO_HOG_MEMORY=1'
    '';

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/trevor/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
