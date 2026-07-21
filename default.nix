{ pkgs ? import <nixpkgs> { } }:

{
  overlay = import ./overlay.nix;
  solc = pkgs.callPackage ./pkgs/solc { };
  foundry = pkgs.callPackage ./pkgs/foundry { };
  halmos = pkgs.callPackage ./pkgs/halmos { };
}
