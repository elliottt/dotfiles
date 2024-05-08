{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wac-cli";
  version = "0.16.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wac";
    rev = "088a728f732afaba95ee9eb93e14dda022e0f1f9";
    sha256 = "sha256-sJES8T7RI/JVdB96Dz3IfMYrgtPMX4CdMwDnucgBqps=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
