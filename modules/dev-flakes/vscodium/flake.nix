{
  inputs = {
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    flake-utils.follows = "nix-vscode-extensions/flake-utils";
    nixpkgs.follows = "nix-vscode-extensions/nixpkgs";
  };

  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          extensions = inputs.nix-vscode-extensions.extensions.${system};
          inherit (pkgs) vscode-with-extensions vscodium;

          packages.default =
            vscode-with-extensions.override {
              vscode = vscodium;
              vscodeExtensions = with extensions; [
                open-vsx.geequlim.godot-tools
                vscode-marketplace.bedirt.gpt-token-counter-live
                vscode-marketplace.spaceshaman.spaceshaman-dark
              ];
            };

          devShells.default = pkgs.mkShell {
            buildInputs = [ packages.default ];
            shellHook = ''
              printf "VSCodium with extensions:\n"
              codium --list-extensions
            '';
          };
        in
        {
          inherit packages devShells;
        });
}

