#!/bin/sh
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.ndebruin.activationPackage && ./result/activate && rm -r result
popd
