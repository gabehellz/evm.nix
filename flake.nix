{
  description = "EVM Nix Overlay";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  nixConfig = {
    extra-substituers = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [ "gabehellz.cachix.org-1:IOBODlL/0AQJ6S8QSEpikmlpiTLpO/EbdHIexZXQb0Q=" ];
  };
  
  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in {
      legacyPackages = forAllSystems (system: import ./default.nix {
        pkgs = import nixpkgs { inherit system; };
      });

      packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});

      overlays.default = import ./overlay.nix;
    };
}
