{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wit-bindgen-cli";
  version = "0.24.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-XvZa80N9rtzmuk6Jrp09Dmm8hwsNZfRPW1kTBpX2nWE=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
