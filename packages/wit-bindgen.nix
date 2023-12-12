{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "wit-bindgen-cli";
  version = "0.16.0";

  src = pkgs.fetchFromGitHub {
    owner = "bytecodealliance";
    repo = "wit-bindgen";
    # rev = "${pname}-${version}";
    rev = "045259a28a1d7e4404fd39613a3b0b31bd40721c";
    sha256 = "sha256-OdHk4YmQgp3qEBz8M+scrgORofQXAUx0fbgEs8PSA5E=";
  };

  doCheck = false;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };
}
