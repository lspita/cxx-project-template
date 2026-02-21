{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            buildInputs = [
              # nix
              nixd
              nil
              nixfmt
              # cmake
              gnumake
              cmake
              neocmakelsp
              # c/c++
              gcc
              gdb
              clang-tools # must be before clang to have the correct clangd in PATH
              clang
              lldb
              valgrind
            ];
            shellHook = ''
              set -a
              source .env 2> /dev/null
              PATH=$(realpath ./scripts):$PATH
              set +a
            '';
          };
      }
    );
}
