#!/bin/bash
source ./.packages.sh

for pkg in "${AUR_PKGS[@]}"; do
	pushd $AUR_PKG_ROOT/$pkg
	./update-pkg.sh
	popd
done


for pkg in "${AUR_PKGS[@]}"; do
	mkdir $pkg
	touch $pkg/$pkg.timer
	touch $pkg/$pkg.service
	touch $pkg/update-pkg.sh
	touch $pkg/PKGBUILD.in
done
