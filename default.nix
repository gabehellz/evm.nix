{ pkgs ? import <nixpkgs> { } }:

{
  overlay = import ./overlay.nix;
  solc = pkgs.callPackage ./pkgs/solc { };
  foundry = pkgs.callPackage ./pkgs/foundry { };
}
