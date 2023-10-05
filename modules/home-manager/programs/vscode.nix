{ pkgs, ... }: {
  enable = true;
  package = pkgs.vscode.fhsWithPackages (ps: with ps; [
    nil
  ]);
}