{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wit-deps";
  version = "0.3.3";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wit-deps";
    rev = "v${version}";
    sha256 = "sha256-peHelLgJBj10NGDxLpqil3iey7WKT+wpLrINcMY+Ax0=";
  };

  doCheck = false;

  postPatch = ''
    cp ${./wit-deps.lock} Cargo.lock
  '';

  cargoLock = {
    lockFile = ./wit-deps.lock;
  };
}
