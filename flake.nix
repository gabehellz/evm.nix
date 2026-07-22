{
  description = "EVM Nix Overlay";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, rust-overlay }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      overlays = [ (import ./.) (import rust-overlay) ];
    in {
      legacyPackages = forAllSystems (system: {
        pkgs = import nixpkgs { inherit system overlays; };
      });

      packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});
      overlays.default = import ./.;
    };
}
