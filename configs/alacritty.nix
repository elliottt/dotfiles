{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window.padding = {
        x = 5;
        y = 5;
      };

      key_bindings = [
        { key = "F11"; action = "ToggleFullscreen"; }
      ];

      font = {
        size = 12;
        normal = {
          family = "FuraMono Nerd Font Mono";
          style = "Regular";
        };
      };
    };
  };
}
