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
    settings.user.name = "Trevor Elliott";
    settings.user.email = lib.mkDefault "awesomelyawesome@gmail.com";
    settings.alias = {
      "lol" = lib.concatStringsSep " " [
        "log"
        "--graph"
        "--abbrev-commit"
        "--pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
      ];
    };
    settings.pull.rebase = true;
    settings.rebase.autoStash = true;
    ignores = [
      ".direnv/"
      ".envrc"
      ".jj/"
    ];
  };

  programs.jujutsu = {
    enable = true;
    settings.user.name = "Trevor Elliott";
    settings.user.email = lib.mkDefault "awesomelyawesome@gmail.com";
    settings.ui.default-command = "log";
    settings.revset-aliases = {
      "closest_bookmark(to)" = "heads(::to & bookmarks() & mutable())";
    };
    settings.aliases = {
      tug = ["bookmark" "move" "-f" "closest_bookmark(@-)" "-t" "@-"];
    };
    settings.merge-tools.nvim = {
      program = "nvim";
      merge-args = ["-d" "$left" "$output" "$right"];
    };
  };

  programs.htop.enable = true;

  programs.ripgrep.enable = true;
  home.file.".config.ripgrep/ripgreprc".text = "";

  # Prompt config
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;
      format = lib.mkDefault (lib.concatStrings [
        "$cmd_duration$username$hostname $directory"
        "\${custom.git_branch}\${custom.git_status}\${custom.jj}"
        "$jobs"
        "$line_break$character"
      ]);
      hostname = {
        ssh_only = true;
        ssh_symbol = "";
        format = "[@$hostname]($style)";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
      };
      jobs = {
        symbol = "";
        number_threshold = 1;
        format = "[\${number}j]($style)";
        style = "purple";
      };
      username = {
        show_always = lib.mkDefault true;
        style_root = "red bold";
        style_user = "white";
        format = "[$user]($style)";
      };
      directory = {
        truncate_to_repo = false;
        truncation_length = 8;
      };
      character = {
        success_symbol = "[%](white)";
        error_symbol = "[%](red)";
        vimcmd_symbol = "[:](green)";
        vimcmd_replace_one_symbol = "[:](purple)";
        vimcmd_replace_symbol = "[:](purple)";
        vimcmd_visual_symbol = "[:](yellow)";
      };
      git_branch = {
        ignore_branches = ["master" "main"];
      };
      custom = {
        jj = {
          description = "The current jj status";
          require_repo = true;
          ignore_timeout = true;
          when = "jj --ignore-working-copy root";
          command = ''
            jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
            separate(" ",
              change_id.shortest(4),
              bookmarks,
              "|",
              concat(
                if(conflict, "💥"),
                if(divergent, "🚧"),
                if(hidden, "👻"),
                if(immutable, "🔒"),
              ),
              raw_escape_sequence("\x1b[1;32m") ++ if(empty, "(empty)"),
              raw_escape_sequence("\x1b[1;32m") ++ coalesce(
                truncate_end(29, description.first_line(), "…"),
                "(no description set)",
              ) ++ raw_escape_sequence("\x1b[0m"),
            )
          '
          '';
        };
        git_branch = {
          description = "Only show git_branch if we're not in a jj repo";
          require_repo = true;
          ignore_timeout = true;
          when = "! jj --ignore-working-copy root";
          command = "starship module git_branch";
          style = "";
        };
        git_status = {
          description = "Only show git_$tatus if we're not in a jj repo";
          require_repo = true;
          ignore_timeout = true;
          disabled = lib.mkDefault false;
          when = "! jj --ignore-working-copy root";
          command = "starship module git_status";
          style = "";
        };
      };
    };
  };

  home.packages = with pkgs; [
    gnumake
    hyperfine
    glow
    gum
  ];

  home.file = {
    ".local/bin/reattach".source = ./bin/reattach;

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
