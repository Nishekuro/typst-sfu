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
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        typst
        tre-command
      ];
    };

    packages.default = pkgs.stdenv.mkDerivation {
      pname = "typst-sfu";
      version = "0.1.0";
      src = ./.;
      buildInputs = [pkgs.typst];
      buildPhase = "typst compile";
    };
  };
}
