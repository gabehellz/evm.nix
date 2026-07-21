{
  lib,
  svm-lists,
  makeRustPlatform,
  rust-bin,
  fetchFromGitHub,
  openssl,
  pkg-config,
}:
let
  rustPlatform = makeRustPlatform {
    cargo = rust-bin.selectLatestNightlyWith (toolchain: toolchain.default);
    rustc = rust-bin.selectLatestNightlyWith (toolchain: toolchain.default);
  };
in
rustPlatform.buildRustPackage rec {
  pname = "aderyn";
  version = "0.6.8";

  src = fetchFromGitHub {
    owner = "Cyfrin";
    repo = pname;
    tag = "aderyn-v${version}";
    hash = "sha256-uHOg7Wsr2LVVnKYWdWx49lPRTEtc7YMgxXsCpR6oG6U=";
  };

  cargoHash = "sha256-5OS0zzRvYDc7VJlZ3UGhBr9ZY+djd1t1lPv0WD5ONhg=";

  buildInputs = [
    openssl
    svm-lists
  ];
  nativeBuildInputs = [ pkg-config ];

  doCheck = false;
  doInstallCheck = true;

  env.SVM_RELEASES_LIST_JSON = "${svm-lists}/list.json";

  installCheckPhase = ''
    $out/bin/aderyn --version > /dev/null
  '';

  meta = {
    description = "A powerful Solidity static analyzer that takes a bird's eye view over your smart contracts.";
    homepage = "https://github.com/Cyfrin/aderyn";
    license = lib.licenses.gpl3Only;
  };
}
