{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-fuzz";
  version = "0.11.2";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-iPfhXdpamzNJIQLezqeDZ7WFo/fKp54wOXcaJVBSZM4=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
