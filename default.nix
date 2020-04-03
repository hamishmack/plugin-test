{ sources ? (import ./nix/sources.nix) # // { "haskell.nix" = ../haskell.nix; }
, pkgs ? import sources.nixpkgs (haskellNixpkgsArgs // { inherit system; })
# where
, nixpkgs ? sources.nixpkgs
, haskellNixpkgsArgs ? import haskellNix
, system ? builtins.currentSystem
, haskellNix ? sources."haskell.nix"
, haskellCompiler ? "ghc865"
}:
let
    project = pkgs.haskell-nix.cabalProject {
        index-state = "2019-12-13T00:00:00Z";
        src = pkgs.haskell-nix.haskellLib.cleanGit { name = "plugin-test"; src = ./.; };
        modules = [
            {
                nonReinstallablePkgs = [ "Cabal" "array" "base" "binary" "bytestring" "containers" "deepseq"
                                         "directory" "filepath" "ghc" "ghc-boot" "ghc-boot-th" "ghc-compact"
                                         "ghc-heap" "ghc-prim" "ghci" "haskeline" "hpc" "integer-gmp"
                                         "libiserv" "mtl" "parsec" "pretty" "process" "rts" "stm"
                                         "template-haskell" "terminfo" "text" "time" "transformers" "unix"
                                         "xhtml"
                                         ];
            }
        ];
    };
    ghcide = (import (sources.ghcide-nix + "/nix") { inherit sources system; }).export.ghcide-ghc865;
in (project.shellFor {
      packages = ps: [ ps.use-case ];
    }).overrideAttrs (attrs: {
      buildInputs = [
        ghcide
        pkgs.haskell-nix.cabal-install
        pkgs.gnused
      ];
    })
