{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "viceroy";
  version = "0.7.0";

  src = pkgs.fetchFromGitHub {
    owner = "fastly";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-ml9N4oxq80A1y7oFE98eifFIEtdcT9IRhXwDMEJ298k=";
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
