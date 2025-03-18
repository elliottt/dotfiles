{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/Users/trevor";

  programs.git.userEmail = "trevor@stripe.com";
  programs.gh.settings.http_unix_socket = "/Users/trevor/.stripeproxy";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nerd-fonts.fira-code

    parallel
    hub
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

    (python3.withPackages (pythonPackages: [
      pythonPackages.lmdb
    ]))
  ];

  programs.rbenv = {
    enable = true;
    enableZshIntegration = true;
  };

  # Helpful aliases for fetching branches that are skipped by default.
  programs.git.aliases = {
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
  '';

  programs.zsh.initExtra = ''
    source ~/.stripe/shellinit/zshrc
  '';

  home.file = {
    ".config/alacritty/alacritty.toml".text = ''
      [window.padding]
      x = 5
      y = 5

      [font]
      size = 12

      [font.normal]
      family = "FiraCode Nerd Font Mono"
      style = "Regular"
    '';
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
