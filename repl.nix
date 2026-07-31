{
  pkgs ? import <nixpkgs> {
    overlays = [
      (import ./.)
      (import (fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
    ];
  }
}:

let
  pythonPackages = pkgs.python3Packages.overrideScope (final: prev: {
    uv-build_0_9_30 = final.callPackage ./pkgs/uv-build_0_9_30 { };
    crytic-compile = final.callPackage ./pkgs/crytic-compile { };
  });
in
{
  solc = pkgs.callPackage ./pkgs/solc { };
  svm-lists = pkgs.callPackage ./pkgs/svm-lists { };
  foundry = pkgs.callPackage ./pkgs/foundry { };
  aderyn = pkgs.callPackage ./pkgs/aderyn { };

  # Python Packages
  halmos = pythonPackages.callPackage ./pkgs/halmos { };
  slither = pythonPackages.callPackage ./pkgs/slither { };
}
