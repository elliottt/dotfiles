{ config, pkgs, ... }:

let
  wrapNixGL = import ../lib/nixgl.nix {
    inherit pkgs;
    nixGL = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel";
  };
in {
  imports = [
    ../programs/alacritty
    ../programs/bakaneko
    ../programs/rust
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  targets.genericLinux.enable = true;

  # Override some alacritty settings
  programs.alacritty.package = wrapNixGL "alacritty" pkgs.alacritty;
  programs.alacritty.settings.font.size = 8;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    qmk
    qmk-udev-rules

    (binutils // { meta.priority = 6; })
    (gcc // { meta.priority = 8; })

    clang_16
    clang-tools_16
  ];

  fonts.fontconfig.enable = true;

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
