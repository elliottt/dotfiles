{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/Users/trevor";

  programs.git.settings.user.email = "trevor@stripe.com";
  programs.gh.settings.http_unix_socket = "/Users/trevor/.stripeproxy";
  programs.jujutsu.settings.user.email = "trevor@stripe.com";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nerd-fonts.fira-code

    parallel
    rsync
    fd
    git-absorb
    graphviz
    nodenv
    rsync
    vale
    wget
    shellcheck
    awscli2
    wasm-tools
    fastmod

    (python3.withPackages (pythonPackages: [
      pythonPackages.lmdb
    ]))
  ];

  programs.rbenv = {
    enable = true;
    enableZshIntegration = true;
  };

  # `git_status` takes way too long in big repos
  programs.starship.settings.custom.git_status.disabled = true;

  # Helpful aliases for fetching branches that are skipped by default.
  programs.git.settings.alias = {
    "remote-fetch" = "!rf() { git config --add remote.origin.fetch +refs/heads/$1:refs/remotes/origin/$1; git fetch origin +$1:refs/remotes/origin/$1; }; rf";
    "remote-purge" = "!rp() { git config --unset remote.origin.fetch \".*$1.*\"; git update-ref -d refs/remotes/origin/$1; }; rp";
  };

  programs.zsh.profileExtra = ''
    # Ensure that nix survives osx updates
    if [[ ! $(command -v nix) && -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';

  programs.zsh.envExtra = ''
    # From stripe IT department
    # export PATH="$HOME/stripe/henson/bin:$PATH"
    # export PATH="$PATH:$HOME/stripe/space-commander/bin"
    export __STRIPE_SHELLINIT_ZSH_SKIP_COMPINIT=1

    export PAY_SSH_CONNECTOR=openssh
  '';

  programs.zsh.completionInit = ''
    autoload -U bashcompinit && bashcompinit
    autoload -U compinit && compinit
  '';

  programs.zsh.initContent = ''
    # STRIPE_DO_NOT_MANAGE=1
    source ~/.stripe/shellinit/zshrc
  '';

  programs.neovim.extraConfig = ''
    set nofixeol
  '';

  home.file = {
    ".config/ghostty/config".text = ''
      background = 000000
    '';
  };
}
