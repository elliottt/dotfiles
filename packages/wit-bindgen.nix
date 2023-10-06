{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wit-bindgen-cli";
  version = "0.12.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wit-bindgen";
    rev = "${pname}-${version}";
    sha256 = "sha256-Hk9ENKkXB86bbtRE6i6bdA2gFGP566A+feHxZCzvw+U=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
