{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wit-bindgen-cli";
  version = "0.28.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-2FzACJ7sTxD5QOgX0odPE4DT1Vuvjg+FxUAxao/bcPA=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
