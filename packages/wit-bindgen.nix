{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wit-bindgen-cli";
  version = "0.24.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wit-bindgen";
    rev = "v${version}";
    sha256 = "sha256-lH5ejZEEtGJbqBTAm0VO2ww+fh+fAtuRlTLfc58WFxc=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
