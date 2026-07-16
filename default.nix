{ pkgs ? import <nixpkgs> { } }:

{
  solc = pkgs.callPackage ./pkgs/solc.nix { };
}
