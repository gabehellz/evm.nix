{
  lib,
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  pkg-config,
  openssl,
  perl,
  svm-lists
}:
let
  binsWithCompletions = [
    "cast"
    "anvil"
    "forge"
  ];
  
in rustPlatform.buildRustPackage rec {
  pname = "foundry";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "foundry-rs";
    repo = pname;
    tag = "v${version}";
    hash = "sha256-pS0V7AbSVowKXWfmk4TM9HyEVO1GL+FCZgdmpCfGcmM=";
  };

  cargoHash = "sha256-Ka751S1YhUQJCJYqD8bgjSm9IZPaBNg50DNDhmROQzs=";  

  buildInputs = [
    openssl
    svm-lists
  ];
  nativeBuildInputs = [ pkg-config perl installShellFiles ];

  doCheck = false;
  doInstallCheck = true;

  env = {
    VERGEN_GIT_SHA = "VERGEN_IDEMPOTENT_OUTPUT";
    SVM_RELEASES_LIST_JSON = "${svm-lists}/list.json";
  };
  
  installCheckPhase = ''
    $out/bin/cast --version > /dev/null
    $out/bin/anvil --version > /dev/null
    $out/bin/forge --version > /dev/null
    $out/bin/chisel --version > /dev/null
  '';

  postInstall = ''
    ${lib.concatMapStringsSep "\n" (bin: ''
      installShellCompletion --cmd ${bin} \
        --bash <($out/bin/${bin} completions bash) \
        --fish <($out/bin/${bin} completions fish) \
        --zsh <($out/bin/${bin} completions zsh) \
    '') binsWithCompletions}
  '';
  
  meta = {
    description = "Blazing fast, portable and modular toolkit for Ethereum application development, written in Rust";
    homepage = "https://github.com/foundry-rs/foundry";
    changelog = "https://github.com/foundry-rs/foundry/releases/tag/v${version}";
    license = lib.licenses.asl20;
  };
}
