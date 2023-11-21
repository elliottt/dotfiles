{ pkgs, ... }:

let
  wrapNixGL = import ../../lib/nixgl.nix { inherit pkgs; };
in {
  home.packages = [
    (wrapNixGL "polybar" pkgs.polybar)
    (wrapNixGL "herbstluftwm" pkgs.herbstluftwm)
    (wrapNixGL "rofi" pkgs.rofi)
  ];

  home.file = {
    ".config/herbstluftwm/autostart" = {
      source = ./autostart;
      executable = true;
    };
    ".config/herbstluftwm/panel.sh" = {
      source = ./panel.sh;
      executable = true;
    };
    ".config/herbstluftwm/polybar.config".source = ./polybar.config;
    ".config/herbstluftwm/rofi-wifi-menu.sh" = {
      source = ./rofi-wifi-menu.sh;
      executable = true;
    };
    ".config/herbstluftwm/rofi.rasi".source = ./rofi.rasi;
  };
}
