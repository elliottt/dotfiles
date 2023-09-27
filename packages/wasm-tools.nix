{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wasm-tools";
  version = "1.0.44";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wasm-tools";
    rev = "wasm-tools-${version}";
    sha256 = "sha256-g7pjfl3aAqYpf3xlCVbpXAglJCKWrztIeMmVOPgIkWQ=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
