{ pkgs, ... }:

{

  # I have trouble using kitty from nixpkgs, as it fails to start due to opengl
  # issues. See https://github.com/NixOS/nixpkgs/issues/80936 for more info.
  home.file = {
    ".config/kitty/kitty.conf".source = ./kitty.conf;
  };

}
