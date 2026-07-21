{
  lib,
  stdenv,
}:

stdenv.mkDerivation {
  pname = "svm-lists";
  version = "0.8.36";

  dontUnpack = true;
  
  installPhase = ''
    install -D ${./linux-amd64.json} $out/list.json
  '';

  meta = {
    description = "List of current and historical builds of the Solidity Compiler";
    homepage = "https://github.com/argotorg/solc-bin";
    changelog = "https://github.com/argotorg/solc-bin";
    license = lib.licenses.gpl3;
  };
}
