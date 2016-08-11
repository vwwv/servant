#!/usr/bin/env bash

set -o nounset
set -o errexit

export PATH=$(stack path --bin-path):$PATH

stack install cabal
cabal update

for package in $(cat sources.txt) ; do
  echo testing $package
  pushd $package
  tinc
  cabal configure --enable-tests --disable-optimization --ghc-options='-Werror'
  cabal build
  cabal test
  popd
done
