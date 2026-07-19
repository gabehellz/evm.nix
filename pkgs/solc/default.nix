{
  lib,
  gccStdenv,
  fetchzip,
  cmake,
  boost,
  z3,
  cvc4,
  cln,
  gmp,
}:

gccStdenv.mkDerivation rec {
  pname = "solc";
  version = "0.8.36";

  src = fetchzip {
    url = "https://github.com/argotorg/solidity/releases/download/v0.8.36/solidity_0.8.36.tar.gz";
    hash = "sha256-qIChFkTTmHklgj06fYvn6Ghi9ZW4rlyY/lvfMWxyVlk=";
  };

  doInstallCheck = true;
  enableParallelBuilding = true;
  doCheck = false;
  
  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DBoost_USE_STATIC_LIBS=OFF"
    "-DSTRICT_Z3_VERSION=OFF"
  ];

  buildInputs = [
    boost
    z3
    cvc4
    cln
    gmp
  ];

  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/solc --version > /dev/null
    runHook postInstallCheck
  '';
  
  meta = {
    mainProgram = "solc";
    description = "The Solidity Contract-Oriented Programming Language";
    homepage = "https://github.com/argotorg/solidity";
    changelog = "https://github.com/argotorg/solidity/releases/tag/v${version}";
    license = lib.licenses.gpl3;
  };
}
