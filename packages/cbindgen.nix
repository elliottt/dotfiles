{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cbindgen";
  version = "0.26.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-vL2iLsUh8U/4WimN3u1S1pHWwuyhX8kQPB3BuQuUVgw=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
