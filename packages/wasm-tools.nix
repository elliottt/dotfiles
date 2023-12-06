{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wasm-tools";
  version = "1.0.54";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wasm-tools";
    rev = "wasm-tools-${version}";
    sha256 = "sha256-10sR+VA0lakAArFzSUWP3p9sKRl8Qf1hwrO8qgzGpZI=";
  };

  # cargo-auditable fails to compile wit-component because of feature issues.
  # Disabling it allows this to build.
  auditable = false;

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
