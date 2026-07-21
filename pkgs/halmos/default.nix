{
  lib,
  python3,
  fetchFromGitHub,
  fetchPypi,
  which
}:
let
  yices-solver = python3.pkgs.buildPythonPackage rec {
    pname = "yices-solver";
    version = "2.6.4";
    pyproject = true;

    src = fetchFromGitHub {
      owner = "a16z";
      repo = pname;
      tag = "v${version}";
      hash = "sha256-a5H3GCSd9VLvo292XNDPvY5LlwI3zXAKcI9CDeJIIsw=";
    };

    build-system = with python3.pkgs; [
      setuptools
      setuptools-scm
    ];

    doCheck = false;

    meta = {
      description = "a Python package to distribute the yices release binaries";
      homepage = "https://github.com/a16z/yices-solver";
      license = lib.licenses.gpl3Only;
    };
  };

  rich = python3.pkgs.buildPythonPackage rec {
    pname = "rich";
    version = "14.0.0";
    pyproject = true;

    src = fetchFromGitHub {
      owner = "Textualize";
      repo = "rich";
      tag = "v${version}";
      hash = "sha256-gnKzb4lw4zgepTfJahHnpw2/vcg8o1kv8KfeVDSHcQI=";
    };

    build-system = with python3.pkgs; [ poetry-core ];

    doCheck = false;

    dependencies = with python3.pkgs; [
      markdown-it-py
      pygments
    ];

    optional-dependencies = {
      jupyter = with python3.pkgs; [ ipywidgets ];
    };

    nativeCheckInputs = with python3.pkgs; [ attrs ] ++ [ which ];

    meta = {
      description = "Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal";
      homepage = "https://github.com/Textualize/rich";
      changelog = "https://github.com/Textualize/rich/blob/v${version}/CHANGELOG.md";
      license = lib.licenses.mit;
    };
  };
in python3.pkgs.buildPythonPackage rec {
  pname = "halmos";
  version = "0.3.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-KDD0If7OpBORnFL0mVl9eW1NSfWg8/B0HCqDmeK9ar8=";
  };

  doCheck = false;

  build-system = with python3.pkgs; [
    setuptools
    setuptools-scm
  ];

  pythonRemoveDeps = [ "z3-solver" ];

  dependencies = with python3.pkgs; [
    sortedcontainers
    toml
    z3-solver
    eth-hash
    xxhash
    psutil
    requests
    python-dotenv
  ] ++ [ rich yices-solver ] ++ z3-solver.requiredPythonModules;
  
  meta = {
    description = "A symbolic testing tool for EVM smart contracts";
    homepage = "https://github.com/a16z/halmos";
    license = lib.licenses.agpl3Only;
  };
}
