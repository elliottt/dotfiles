{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-component";
  version = "0.5.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = pname;
    rev = "87949555d067e92a1872c03daa272794a6c0f6a5";
    sha256 = "sha256-N2y5HgKOQB0Z3B6+YJc6VSxr6+ZZ6iLHUy1GHTgGxdg=";
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
