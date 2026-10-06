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
  version = "0.8.37";

  src = fetchzip {
    url = "https://github.com/argotorg/solidity/releases/download/v0.8.37/solidity_0.8.37.tar.gz";
    hash = "sha256-RQmyCTM8Fzkh3J7vkMKd6ZGcTojmSM4RjALaPsJ0rDE=";
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
    $out/bin/solc --version > /dev/null
  '';
  
  meta = {
    mainProgram = "solc";
    description = "The Solidity Contract-Oriented Programming Language";
    homepage = "https://github.com/argotorg/solidity";
    changelog = "https://github.com/argotorg/solidity/releases/tag/v${version}";
    license = lib.licenses.gpl3;
  };
}
