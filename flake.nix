{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    src = pkgs.lib.fileset.toSource {
      root = ./.;
      fileset = pkgs.lib.fileset.unions [
        ./lib.typ
        ./examples
      ];
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        typst
        tre-command
        poppler-utils
      ];
    };

    packages.${system}.default =
      pkgs.runCommand "typst-sfu.zip" {
        inherit src;
        nativeBuildInputs = [pkgs.zip];
      } ''
        mkdir typst-sfu

        cp $src/lib.typ typst-sfu/
        cp -r $src/examples typst-sfu/examples

        zip -rX9 $out typst-sfu
      '';
  };
}
