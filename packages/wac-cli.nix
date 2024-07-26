{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wac-cli";
  version = "0.5.0";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-3s1xQ2jojU9Mhpn2W3E863E2aprJsL4RFTnfYTGx9A4=";
  };

  nativeBuildInputs = [
    pkgs.pkg-config
    pkgs.openssl.dev
  ];

  buildInputs = [
    pkgs.openssl
  ];

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
