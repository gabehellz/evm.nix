(final: prev:
  let
    pythonPackages = final.python3Packages.overrideScope (fp: pv: {
      uv-build_0_9_30 = fp.callPackage ./pkgs/uv-build_0_9_30 { };
      crytic-compile = fp.callPackage ./pkgs/crytic-compile { };
    });
  in
    {
      solc = final.callPackage ./pkgs/solc { };
      svm-lists = final.callPackage ./pkgs/svm-lists { };
      foundry = final.callPackage ./pkgs/foundry { };
      aderyn = final.callPackage ./pkgs/aderyn { };

      # Python Packages
      halmos = pythonPackages.callPackage ./pkgs/halmos { };
      slither = pythonPackages.callPackage ./pkgs/slither { };
    })
