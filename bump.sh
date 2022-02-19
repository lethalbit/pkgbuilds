#!/bin/bash
source ./.packages.sh

for pkg in "${AUR_PKGS[@]}"; do
	pushd $AUR_PKG_ROOT/$pkg
	./update-pkg.sh
	popd
done
