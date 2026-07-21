{
  description = "EVM Nix Overlay";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituers = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [ "gabehellz.cachix.org-1:IOBODlL/0AQJ6S8QSEpikmlpiTLpO/EbdHIexZXQb0Q=" ];
  };
  
  outputs = { self, nixpkgs, rust-overlay }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      overlays = [ (import ./overlay.nix) (import rust-overlay) ];
    in {
      legacyPackages = forAllSystems (system: import ./default.nix {
        pkgs = import nixpkgs { inherit system overlays; };
      });

      packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});

      overlays.default = import ./overlay.nix;
    };
}
