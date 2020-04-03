#!/usr/bin/env bash

sed -i -e "s|-package-db=.*|-package-db=$(ghc-pkg list | head -n1)|" use-case/hie.yaml
cd use-case
ghcide src/Ref.hs

