{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "viceroy";
  version = "0.10.2";

  src = pkgs.fetchCrate {
    inherit pname version;
    sha256 = "sha256-G9hVSLLUO56cYHksa5C1gtp/WO1Sls23kzVVkjC/qkE=";
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
