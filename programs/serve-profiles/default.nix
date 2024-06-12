{ pkgs, ... }:

{

  home.file = {
    ".local/bin/serve-profiles" = {
      executable = true;
      source = pkgs.substituteAll {
        src = ./serve-profiles;
        caddy = pkgs.caddy;
      };
    };
  };

}
