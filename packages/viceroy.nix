{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "viceroy";
  version = "0.9.6";

  src = pkgs.fetchFromGitHub {
    owner = "fastly";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-tJLx/dts7C5yupJX2jkRiAQumlPtlg2HzFx11jQczzE=";
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
