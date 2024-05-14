{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "viceroy";
  version = "0.9.6";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-Bu36pAXKIQLYho/iVYeK+8LXddyvMXwHtpJTqxAg++c=";
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
