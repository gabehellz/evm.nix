(final: prev: {
  solc = final.callPackage ./pkgs/solc { };
  svm-lists = final.callPackage ./pkgs/svm-lists { };      
  foundry = final.callPackage ./pkgs/foundry { };
  halmos = final.python3Packages.callPackage ./pkgs/halmos { };
  aderyn = final.callPackage ./pkgs/aderyn { };
  slither = final.python3Packages.callPackage ./pkgs/slither { };
})
