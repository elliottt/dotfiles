{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cbindgen";
  version = "0.24.5";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-eydzdqstf2hqGAdgQ0/TNqDCxhbvbSOGPaWDmsw17RQ=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
