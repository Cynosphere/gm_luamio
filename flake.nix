{
  description = "Cross-compilation shell for x86_64-windows";

  inputs.nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      crossPkgs = pkgs.pkgsCross.mingwW64;
    in
    {
      devShells.${system}.default = crossPkgs.mkShell {
        nativeBuildInputs = with crossPkgs.buildPackages; [
          gcc
          binutils
          premake5
          gnumake
          gendef
        ];

        buildInputs = with crossPkgs; [
          windows.mingw_w64_headers
        ];

        shellHook = ''
          export CC=x86_64-w64-mingw32-gcc
          export CXX=x86_64-w64-mingw32-g++
        '';
      };
    };
}
