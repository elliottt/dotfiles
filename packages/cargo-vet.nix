{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-vet";
  version = "0.8.0";

  src = pkgs.fetchFromGitHub {
    owner = "mozilla";
    repo = "cargo-vet";
    rev = "8c8b6d7a5237544c613de616a031586587f49a42";
    sha256 = "sha256-WBoPDF69O4jhBvsETnFyGCcUGcaVbsRwUfIJoRt1mk8=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
