{ pkgs, ... }:

{
  programs.alacritty = with pkgs; {
    enable = true;

    settings.window.padding = lib.mkDefault {
      x = 5;
      y = 5;
    };

    settings.keyboard.bindings = lib.mkDefault [
      { key = "F11"; action = "ToggleFullscreen"; }
    ];

    settings.font.size = lib.mkDefault 12;

    settings.font.normal = lib.mkDefault {
      family = "FiraCode Nerd Font Mono";
      style = "Regular";
    };
  };
}
