#!/bin/bash

_update() {
	[ ! -d "yosys" ] && git clone --depth 1 https://github.com/YosysHQ/yosys.git

	cd ./yosys
	git pull
	cd ..
}

_version() {
	cd ./yosys
	git describe --tag --always
	cd ..
}

_yosys_hash() {
	cd ./yosys
	git rev-parse --short master
	cd ..
}


_mkpkg() {
	sed -e "s/@YOSYS_VER@/$(TZ=UTC date '+%Y%m%d')_$(_version | sed 's/-/_/g')/" \
		-e "s/@YOSYS_HASH@/$(_yosys_hash)/" PKGBUILD.in > PKGBUILD
	makepkg --printsrcinfo > .SRCINFO
}

_update
_mkpkg
version="$(TZ=UTC date '+%Y%m%d')_$(_version | sed 's/-/_/g')"
git add PKGBUILD PKGBUILD.in .SRCINFO yosys.conf .gitignore
git commit -m "Bumped yosys-nightly Version to $version"
git push origin main:master
echo $version > .version
