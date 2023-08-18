{ pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;

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
    pkgs.glow
    pkgs.gum

    (pkgs.binutils // { meta.priority = 6; })
    (pkgs.gcc // { meta.priority = 8; })

    pkgs.llvmPackages_16.clang
    pkgs.clang-tools_16
  ];

  home.file = {
    ".local/bin/reattach".source = ./bin/reattach;

    ".config/ripgrep/ripgreprc".text = "";

    ".config/glow/glow.yml".text = pkgs.lib.generators.toYAML {} {
      # style name or JSON path (default "auto")
      style = "auto";
      # show local files only; no network (TUI-mode only)
      local = false;
      # mouse support (TUI-mode only)
      mouse = false;
      # use pager to display markdown
      pager = true;
      # word-wrap at width
      width = 80;
    };

    ".config/nix/nix.conf".text = ''
    experimental-features = nix-command
    '';
  };
}
