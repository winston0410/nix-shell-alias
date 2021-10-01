{
  description = "Testing flake for alias";

  outputs = { self, nixpkgs }:
    let system = "x86_64-linux";
    in {
      devShell.${system} = (({ pkgs, ... }:
        let 
          alias = pkgs.writeShellScriptBin "test-alias" ''
          alias foo=nvim
          '';
        in pkgs.mkShell {
          buildInputs = with pkgs; [
              alias
          ];

          shellHook = ''
              echo ${alias}/bin/test-alias
              source ${alias}/bin/test-alias
              export hello=world
          '';
        }) { pkgs = nixpkgs.legacyPackages.${system}; });
    };
}
