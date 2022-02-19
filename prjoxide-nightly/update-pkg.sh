#!/bin/bash

_update() {
	[ ! -d "prjoxide" ] && git clone --depth 1 https://github.com/gatecat/prjoxide.git
	[ ! -d "prjoxide-db" ] && git clone --depth 1 https://github.com/gatecat/prjoxide-db.git

	cd ./prjoxide
	git pull
	cd ../prjoxide-db
	git pull
	cd ..
}

_version() {
	cd ./prjoxide
	git describe --tag --always
	cd ..
}

_oxide_hash() {
	cd ./prjoxide
	git rev-parse --short master
	cd ..
}

_db_hash() {
	cd ./prjoxide-db
	git rev-parse --short master
	cd ..
}

_mkpkg() {
	sed -e "s/@OXIDE_VER@/$(TZ=UTC date '+%Y%m%d')_$(_version | sed 's/-/_/g')/" \
		-e "s/@OXIDE_HASH@/$(_oxide_hash)/" \
		-e "s/@DB_HASH@/$(_db_hash)/" PKGBUILD.in > PKGBUILD
	makepkg --printsrcinfo > .SRCINFO
}

_update
_mkpkg
version="$(TZ=UTC date '+%Y%m%d')_$(_version | sed 's/-/_/g')"
git add PKGBUILD PKGBUILD.in .SRCINFO .gitignore
git commit -m "Bumped prjoxide Version to $version"
git push origin main:master
echo $version > .version
