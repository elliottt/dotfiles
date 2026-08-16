{ config, pkgs, ... }:

{
  imports = [
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  targets.genericLinux.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  ];

  home.file = {

    ".xmodmap".text = ''
      remove Lock = Caps_Lock
      keysym Caps_Lock = Control_L
      add Control = Control_L
    '';

    ".xsession" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        compton --shadow-exclude argb -b

        xset r rate 200 20
        xmodmap ~/.xmodmap

        eval $(ssh-agent)

        feh --bg-tile ~/Documents/cat_tile.png

        exec dbus-launch herbstluftwm --locked
      '';
    };

  };
}
