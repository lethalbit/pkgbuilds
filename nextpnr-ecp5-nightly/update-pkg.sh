#!/bin/bash

_update() {
	[ ! -d "nextpnr" ] && git clone -–depth 1 https://github.com/YosysHQ/nextpnr.git

	cd ./nextpnr
	git pull
	cd ..
}

_version() {
	cd ./nextpnr
	git describe --tag --always
	cd ..
}

_hash() {
	cd ./nextpnr
	git rev-parse --short master
	cd ..
}


_mkpkg() {
	sed -e "s/@NPR_VER@/$(TZ=UTC date '+%Y%m%d')_$(_version | sed 's/-/_/g')/" \
		-e "s/@NPR_HASH@/$(_hash)/" PKGBUILD.in > PKGBUILD
	makepkg --printsrcinfo > .SRCINFO
}

_update
_mkpkg
version="$(TZ=UTC date '+%Y%m%d')_$(_version | sed 's/-/_/g')"
git add PKGBUILD PKGBUILD.in .SRCINFO .gitignore
git commit -m "Bumped nextpnr-ecp5 Version to $version"
git push origin main:master
echo $version > .version
