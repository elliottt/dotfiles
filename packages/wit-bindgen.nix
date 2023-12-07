{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wit-bindgen-cli";
  version = "0.16.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wit-bindgen";
    rev = "${pname}-${version}";
    sha256 = "sha256-QqLTXvzBobDsdwo30yUFK2bHedawiYPni2zhKk6I7j8=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
