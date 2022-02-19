#!/bin/bash

_update() {
	[ ! -d "prjtrellis" ] && git clone --depth 1 https://github.com/YosysHQ/prjtrellis.git
	[ ! -d "prjtrellis-db" ] && git clone --depth 1 https://github.com/YosysHQ/prjtrellis-db.git

	cd ./prjtrellis
	git pull
	cd ../prjtrellis-db
	git pull
	cd ..
}

_version() {
	cd ./prjtrellis
	git describe --tag --always
	cd ..
}

_trel_hash() {
	cd ./prjtrellis
	git rev-parse --short master
	cd ..
}

_db_hash() {
	cd ./prjtrellis-db
	git rev-parse --short master
	cd ..
}

_mkpkg() {
	sed -e "s/@TREL_VER@/$(TZ=UTC date '+%Y%m%d')_$(_version | sed 's/-/_/g')/" \
		-e "s/@TREL_HASH@/$(_trel_hash)/" \
		-e "s/@DB_HASH@/$(_db_hash)/" PKGBUILD.in > PKGBUILD
	makepkg --printsrcinfo > .SRCINFO
}

_update
_mkpkg
version="$(TZ=UTC date '+%Y%m%d')_$(_version | sed 's/-/_/g')"
git add PKGBUILD PKGBUILD.in .SRCINFO .gitignore
git commit -m "Bumped prjtrellis-nightly Version to $version"
git push origin main:master
echo $version > .version
