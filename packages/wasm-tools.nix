{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wasm-tools";
  version = "1.0.38";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wasm-tools";
    rev = "wasm-tools-${version}";
    sha256 = "sha256-+lJbZinLUoTZU5elMdrwN80VyPFDWlqNuWyA35/xGEQ=";
  };

  doCheck = false;

  postPatch = ''
  cp ${./wasm-tools.lock} Cargo.lock
  '';

  cargoLock = {
    lockFile = ./wasm-tools.lock;
  };
}
