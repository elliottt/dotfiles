{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-vet";
  version = "0.9.1";

  src = pkgs.fetchFromGitHub {
    owner = "mozilla";
    repo = "cargo-vet";
    rev = "5bd670061a22074eb5ee9d69feccc5900df00ec3";
    sha256 = "sha256-676hoawqU3KTf2TnHdVAdTEgK4NLIOb4zHTmEYm1d1E=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
