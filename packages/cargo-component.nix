{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-component";
  version = "0.16.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-7YgCgx+SZicMeuYaXqYdmaNQUJ4Gv4ECJf9kuL9X+LY=";
  };

  nativeBuildInputs = [
    pkgs.pkg-config
    pkgs.openssl.dev
    pkgs.zlib.dev
  ];

  buildInputs = [
    pkgs.openssl
    pkgs.zlib
  ];

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
