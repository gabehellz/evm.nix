(final: prev: {
  solc = final.callPackage ./pkgs/solc { };
  foundry = final.callPackage ./pkgs/foundry { };
  halmos = final.callPackage ./pkgs/halmos { };
})

  
