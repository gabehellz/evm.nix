{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  packaging,
  prettytable,
  pycryptodome,
  crytic-compile,
  web3,
  eth-abi,
  eth-typing,
  eth-utils
}:

buildPythonPackage rec {
  pname = "slither";
  version = "0.11.6";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "crytic";
    repo = "slither";
    tag = version;
    hash = "sha256-Uo6mwJ9keG3tUMvh4v0MEJWJ1WStGxvzzh3PmHy/gCs=";
  };

  build-system = [ hatchling ];

  doCheck = false;
  doInstallCheck = true;

  dependencies = [
    packaging
    prettytable
    pycryptodome
    crytic-compile
    web3
    eth-abi
    eth-typing
    eth-utils
  ];

  installCheckPhase = ''
    $out/bin/slither --version > /dev/null
  '';

  meta = {
    mainProgram = "slither";
    description = "Static Analyzer for Solidity and Vyper";
    homepage = "https://github.com/crytic/slither";
    license = lib.licenses.gpl3;
  };
}
