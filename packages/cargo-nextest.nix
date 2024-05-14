{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-nextest";
  version = "0.9.70";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-B+fKacQG1Xsgqfsb5ob4rxHjGg7BZTSQiyNOG3m5s3o=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
