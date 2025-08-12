{
  description = "elliottt's home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    two-trucs = {
      url = "github:elliottt/two-trucs";
      flake = false;
    };

    wit-nvim = {
      url = "github:elliottt/wit.nvim";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, home-manager, nixgl, two-trucs, wit-nvim, ... }:
    let

      mkHostConfig = cfg:
        let

          pkgs = import nixpkgs {
            system = cfg.system or "x86_64-linux";
            overlays = [ nixgl.overlay ];
          };

        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit two-trucs wit-nvim;
            use-two-trucs = cfg.two-trucs or true;
          };
          modules = [
            cfg.home
            ./home.nix
          ];
        };

    in {
      homeConfigurations = {

        "trevor@badtz-maru" = mkHostConfig {
          home = ./hosts/badtz-maru.nix;
        };

        "trevor@bakaneko" = mkHostConfig {
          home = ./hosts/bakaneko.nix;
        };

        "trevor@st-trevor1" = mkHostConfig {
          home = ./hosts/st-trevor1.nix;
          system = "aarch64-darwin";
          two-trucs = false;
        };

      };
    };
}
