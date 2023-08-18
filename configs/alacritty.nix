{ pkgs, ... }:

{
  # Assuming a distro install until I can figure out how to not need `nixGL` to
  # wrap a use of alacritty from nixpkgs.
  home.file = {
    ".config/alacritty/alacritty.yml".text = ''
      window:
        padding:
          x: 5
          y: 5

      font:
        size: 8
        normal:
          family: "monospace"
          style: "Regular"
    '';
  };
}
