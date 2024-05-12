{
  description = "elliottt's home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, nixgl, ... }:
    let

      mkHostConfig = cfg:
        let

          pkgs = import nixpkgs {
            system = cfg.system or "x86_64-linux";
            overlays = [ nixgl.overlay ];
          };

        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ cfg.home ];
        };

    in {
      homeConfigurations = {

        "trevor@badtz-maru" = mkHostConfig {
          home = ./hosts/badtz-maru.nix;
        };

        "trevor@bakaneko" = mkHostConfig {
          home = ./hosts/bakaneko.nix;
        };

        "trevor@telliott" = mkHostConfig {
          home = ./hosts/telliott.nix;
        };

        "trevor@trogdor" = mkHostConfig {
          home = ./hosts/trogdor.nix;
        };

      };
    };
}
