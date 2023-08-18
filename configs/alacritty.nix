{ pkgs, ... }:

{
  # Assuming a distro install until I can figure out how to not need `nixGL` to
  # wrap a use of alacritty from nixpkgs.
  home.file = {
    ".config/alacritty/alacritty.yaml".text = pkgs.lib.generators.toYAML {} {
      window.padding = {
        x = 5;
        y = 5;
      };

      font = {
        normal = {
          family = "monospace";
          style = "Regular";
        };
        size = 8.0;
      };
    };
  };
}
