{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wit-bindgen-cli";
  version = "0.26.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-lm1cXuo41TZ4CaxheWDQrlhZJovPhgxrHpGp/O0P8+E=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
