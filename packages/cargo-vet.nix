{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-vet";
  version = "0.9.1";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-yRq1YjS33vIlzNxw8k2gEaBt8ew4U8KcEpF6N9gSuK0=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
