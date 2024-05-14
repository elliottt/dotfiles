{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wasm-tools";
  version = "1.207.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-UaiQpLkNhGmeQaZ3d4ROHFZeX4ULOUWwv2HBGpNUz0I=";
  };

  # cargo-auditable fails to compile wit-component because of feature issues.
  # Disabling it allows this to build.
  auditable = false;

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
