{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-component";
  version = "0.3.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = pname;
    rev = "5cddf6df7fd5ab5aa9bfd66f4cf2e2f6cc7d72f9";
    sha256 = "sha256-zXpV5BkZTcvrDNt0rj1IvIuCQuxJW3tDr3h0PaBMMcg=";
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
