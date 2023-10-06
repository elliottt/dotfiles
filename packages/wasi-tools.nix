{ pkgs ? import <nixpkgs> {} }:

let

  repo = pkgs.fetchFromGitHub {
    owner = "WebAssembly";
    repo = "wasi-tools";
    rev = "5223b90013801a1cc779509dd18a4161e41e12c7";
    sha256 = "sha256-GoV7H8PccHYkIm6lqSiaYVCbM897GSKHSkNxrVF+Ge0=";
  };

in pkgs.rustPlatform.buildRustPackage rec {
  pname = "wasi-tools";
  version = "0.1.0";

  src = "${repo}/wit-abi";

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
