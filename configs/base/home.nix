{ pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Unfree program filter
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "zoom"
    ];

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
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
    aliases = {
      "lol" = lib.concatStringsSep " " [
        "log"
        "--graph"
        "--abbrev-commit"
        "--pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
      ];
    };
    extraConfig = {
      pull.rebase = true;
      rebase.autoStash = true;
    };
    ignores = [
      ".direnv/"
      ".envrc"
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

    # (pkgs.binutils // { meta.priority = 6; })
    # (pkgs.gcc // { meta.priority = 8; })

    pkgs.clang_16
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
      experimental-features = nix-command flakes
    '';
  };
}
