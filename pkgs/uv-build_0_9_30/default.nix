{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  rustPlatform,
}:

buildPythonPackage rec {
  pname = "uv-build";
  version = "0.9.30";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "astral-sh";
    repo = "uv";
    tag = version;
    hash = "sha256-PDp7yktF2ek6KVlJvYsLn7VgV1ulgWnjAXKozJW3JKU=";
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
  ];

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-KoVAUbVheq/x5e7scqf8ZSyC0ZAXlcZJ7svuiuT7NzQ=";
  };

  buildAndTestSubdir = "crates/uv-build";
  maturinBuildProfile = "minimal-size";
  pythonImportsCheck = [ "uv_build" ];

  doCheck = false;

  meta = {
    description = "Minimal build backend for uv";
    homepage = "https://docs.astral.sh/uv/reference/settings/#build-backend";
    changelog = "https://github.com/astral-sh/uv/blob/${version}/CHANGELOG.md";
    license = with lib.licenses; [ asl20 mit ];
  };
}
