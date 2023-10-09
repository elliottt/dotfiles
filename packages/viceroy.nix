{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "viceroy";
  version = "0.9.1";

  src = pkgs.fetchFromGitHub {
    owner = "fastly";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Z5poizMXp4xgn0Tx0E36rvueBx3dFL7++alewqG9E9w=";
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
