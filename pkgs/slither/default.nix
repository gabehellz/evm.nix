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
  version = "0.11.5";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "crytic";
    repo = "slither";
    tag = version;
    hash = "sha256-sy1vE9XniwyvvZRFnnKhPfmYh2auHHcMel9sZx2YK3c=";
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
