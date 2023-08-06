{ pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--layout=reverse"
    ];
  };

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
    pkgs.gnumake
    pkgs.bazelisk
    pkgs.hyperfine
    pkgs.openssl
    pkgs.zlib.dev
    pkgs.pkg-config

    (pkgs.binutils // { meta.priority = 6; })
    (pkgs.gcc // { meta.priority = 8; })

    pkgs.llvmPackages_16.clang
    pkgs.clang-tools_16
  ];

  home.file = {
    ".local/bin/reattach".source = ./bin/reattach;

    ".config/ripgrep/ripgreprc".text = "";
  };
}
