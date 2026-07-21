{
  pkgs ? import <nixpkgs> {
    overlays = [
      (import ./overlay.nix)
      (import (fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
    ];
  }
}:

{
  solc = pkgs.callPackage ./pkgs/solc { };
  svm-lists = pkgs.callPackage ./pkgs/svm-lists { };
  foundry = pkgs.callPackage ./pkgs/foundry { };
  halmos = pkgs.python3Packages.callPackage ./pkgs/halmos { };
  aderyn = pkgs.callPackage ./pkgs/aderyn { };
  slither = pkgs.python3Packages.callPackage ./pkgs/slither { };
}
