#!/bin/bash
source ./.packages.sh

for pkg in "${AUR_PKGS[@]}"; do
	pushd $AUR_PKG_ROOT/$pkg
	bash ./update-pkg.sh
	popd
done
