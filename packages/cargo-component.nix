{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "cargo-component";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = pname;
    rev = "6af088a2692f5f9c1a4ff50b9bb19b7cdd09e66b";
    sha256 = "sha256-x6wbQ3XpZVGUF7MsOPLxP+ANZwAvlj4GV1IzRpOBcws=";
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
    outputHashes = {
      "wit-bindgen-0.9.0" = "sha256-/ozrGPnk2gYuofU7qn2qYJb6cL+7nOzj8FF0BgbKXDY=";
      "warg-api-0.1.0" = "sha256-A5FQ/nbuzV8ockV6vOMKUEoJKeaId3oyZU1QeNpd1Zc=";
    };
  };
}
