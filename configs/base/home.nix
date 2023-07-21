{ pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.exa.enable = true;

  programs.fzf.enable = true;

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      aliases.co = "pr checkout";
    };
  };

  programs.git = {
    enable = true;
    userName = "Trevor Elliott";
    includes = [
      { path = ./git/aliases; }
    ];
  };

  programs.htop.enable = true;

  programs.ripgrep.enable = true;

  home.packages = [
    pkgs.bazelisk
    pkgs.hyperfine
    pkgs.openssl

    (pkgs.binutils // { meta.priority = 6; })
    (pkgs.gcc // { meta.priority = 8; })

    pkgs.llvmPackages_16.clang
    pkgs.clang-tools_16
  ];
}
