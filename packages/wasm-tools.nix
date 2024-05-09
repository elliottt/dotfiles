{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wasm-tools";
  version = "1.207.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wasm-tools";
    rev = "v${version}";
    sha256 = "sha256-aDEJmtk/1lwd4+xCdB6/qALvUOzbC8txTi36FhyiwMw=";
  };

  # cargo-auditable fails to compile wit-component because of feature issues.
  # Disabling it allows this to build.
  auditable = false;

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
