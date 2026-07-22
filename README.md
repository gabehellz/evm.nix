# evm.nix

Nix overlay for tools and software used in EVM smart contracts.

## Packages

Packages included in this overlay:

- [x] [solc](https://github.com/argotorg/solidity)
- [x] [foundry](https://github.com/foundry-rs/foundry)
- [x] [halmos](https://github.com/a16z/halmos)
- [x] [slither](https://github.com/crytic/slither)
- [x] [aderyn](https://github.com/Cyfrin/aderyn)
- [ ] [echidna](https://github.com/crytic/echidna)

## Usage: [devenv](https://devenv.sh/) (recommended)

Initialize `devenv.nix` and `devenv.yaml` files in your solidity project root:

``` shell
$ devenv init
```

Edit your `devenv.nix` file:

``` nix
# devenv.nix
{ pkgs, ... }:

{
  languages.solidity = {
    enable = true;
    package = pkgs.solc;

    foundry = {
      enable = true;
      package = pkgs.foundry;
    };
  };
}
```

And add this repo as an input in the `devenv.yaml` file, activating the `default` overlay:

``` yaml
# devenv.yaml
inputs:
  evm-nix:
    url: github:gabehellz/evm.nix/master
    overlays:
    - default
  nixpkgs:
    url: github:cachix/devenv-nixpkgs/rolling
```

Now, activate the developer environment:

``` shell
$ devenv shell
```

Or, if you want to use [nix-direnv](https://github.com/nix-community/nix-direnv), create a `.envrc` file with the following content:

``` shell
#!/usr/bin/env bash
export DIRENV_WARN_TIMEOUT=20s
eval "$(devenv direnvrc)"
use devenv
```

And run:

``` shell
$ direnv allow
```

To automatically enter the developer environment every time you enter this directory.

## Usage: flakes

Initialize a `flake.nix` file in your solidity project root:

``` shell
$ nix flake init
```

And paste the following code in your `flake.nix`:

``` nix
# flake.nix
{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    evm-nix = {
      url = "github:gabehellz/evm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, evm-nix }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ evm-nix.overlays.default ];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          solc
          foundry
        ];
      };
    };
}
```

Now, enter the dev shell we just created:

``` shell
$ nix develop
```

Or, if you want to use [nix-direnv](https://github.com/nix-community/nix-direnv), create a `.envrc` file with the following content:

``` shell
#!/usr/bin/env bash
use flake .
```

And run:

``` shell
$ direnv allow
```

To automatically enter the dev shell every time you enter this directory.

## Usage: nix

Create a `default.nix` file with the following content:

``` shell
# default.nix
with import <nixpkgs> {
  overlays = [
    (import (fetchTarball "https://github.com/gabehellz/evm.nix/archive/master.tar.gz"))
  ];
};

mkShell {
  buildInputs = [
    solc
    foundry
  ];
}
```

Now, enter the created shell environment:

``` shell
nix-shell
```

Or, if you want to use [nix-direnv](https://github.com/nix-community/nix-direnv), create a `.envrc` file with the following content:

``` shell
#!/usr/bin/env bash
use nix .
```

And run:

``` shell
$ direnv allow
```

To automatically enter the created shell environment every time you enter this directory.

## Related

EVM-related nix overlays:
- https://github.com/hellwolf/solc.nix
- https://github.com/shazow/foundry.nix
- https://github.com/nix-community/ethereum.nix
