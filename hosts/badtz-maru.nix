{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  targets.genericLinux.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bazelisk
    p7zip
  ];

  programs.zsh.envExtra = ''
  export COLORTERM="truecolor"
  '';

  services.ssh-agent.enable = true;
}
