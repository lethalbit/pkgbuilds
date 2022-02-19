#!/bin/bash

_update() {
	[ ! -d "icestorm" ] && git clone --depth 1 https://github.com/YosysHQ/icestorm.git

	cd ./icestorm
	git pull
	cd ..
}

_version() {
	cd ./icestorm
	git describe --tag --always
	cd ..
}

_hash() {
	cd ./icestorm
	git rev-parse --short master
	cd ..
}


_mkpkg() {
	sed -e "s/@ICE_VER@/$(TZ=UTC date '+%Y%m%d')_$(_version)/" \
		-e "s/@ICE_HASH@/$(_hash)/" PKGBUILD.in > PKGBUILD
	makepkg --printsrcinfo > .SRCINFO
}

_update
_mkpkg
version="$(TZ=UTC date '+%Y%m%d')_$(_version)"
git add PKGBUILD PKGBUILD.in .SRCINFO .gitignore
git commit -m "Bumped icestorm Version to $version"
git push origin main:master
echo $version > .version
