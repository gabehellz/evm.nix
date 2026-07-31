{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  uv-build_0_9_30,
  pycryptodome,
  cbor2,
  solc-select,
}:

buildPythonPackage rec {
  pname = "crytic-compile";
  version = "0.4.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "crytic";
    repo = pname;
    tag = version;
    hash = "sha256-0zpalWsyFzsgSrmTi9WyHfRcRympv2WoJNEtzpWXmGk=";
  };

  build-system = [ uv-build_0_9_30 ];

  doCheck = false;
  doInstallCheck = false;

  dependencies = [
    pycryptodome
    cbor2
    solc-select
  ];

  meta = {
    description = "Abstraction layer for smart contract build systems";
    homepage = "https://github.com/crytic/crytic-compile";
    changelog = "https://github.com/crytic/crytic-compile/releases/tag/${version}";
    license = lib.licenses.agpl3Only;
  };
}
