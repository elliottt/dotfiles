{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-nextest";
  version = "0.9.72";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-2+3zC/duMpXOwhbQVmpXmoVqCfTxNKFRswsFO7tWi1E=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
