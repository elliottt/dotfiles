{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wasm-tools";
  version = "1.214.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-7kkcNTLlIvslb1rZ4eaHJq7UAL3R8M0JFZHwgAKQrkY=";
  };

  # cargo-auditable fails to compile wit-component because of feature issues.
  # Disabling it allows this to build.
  auditable = false;

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
