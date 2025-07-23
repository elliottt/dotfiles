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

  imports = [
    ./programs/neovim
    ./programs/tmux
    ./programs/zsh
    ./programs/bazel
  ];

  fonts.fontconfig.enable = true;

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
    defaultCommand = "${pkgs.fd}/bin/fd --type f";
  };


  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
    settings.aliases.co = "pr checkout";
    settings.aliases.mine = "pr list --author @me";
  };

  programs.git = {
    enable = true;
    userName = "Trevor Elliott";
    userEmail = lib.mkDefault "awesomelyawesome@gmail.com";
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

  programs.jujutsu = {
    enable = true;
    settings.user.name = "Trevor Elliott";
    settings.user.email = lib.mkDefault "awesomelyawesome@gmail.com";
    settings.ui.default-command = "log";
  };

  programs.htop.enable = true;

  programs.ripgrep.enable = true;

  home.packages = with pkgs; [
    gnumake
    hyperfine
    glow
    gum
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
