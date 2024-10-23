{ pkgs, lib, ... }:

{
  # I don't have any NixOS machines.
  #
  # REMEMBER: if programs like alacritty are not found by gnome3, make sure that
  # the home-manager env vars are sourced in ~/.profile. That script contains
  # the definitions of things like `XDG_DATA_DIRS` which are used by gnome3 to
  # find .desktop files that describe what can be launched.

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

  programs.eza.enable = true;

  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--layout=reverse"
    ];
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    settings.aliases.co = "pr checkout";
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
  };
}
