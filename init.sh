#!/bin/bash
source ./.packages.sh

## Only needed once we start doing binary packages
# ln -s $(pwd)/clean-pkgs.service /etc/systemd/system/clean-pkgs.service
# ln -s $(pwd)/clean-pkgs.timer /etc/systemd/system/clean-pkgs.timer

# systemctl daemon-reload
# systemctl enable clean-pkgs.timer
# systemctl start clean-pkgs.timer

for pkg in "${AUR_PKGS[@]}"; do
	echo "Initializing $pkg"
	ln -s $AUR_PKG_ROOT/$pkg/$pkg.timer /etc/systemd/system/$pkg.timer
	ln -s $AUR_PKG_ROOT/$pkg/$pkg.service /etc/systemd/system/$pkg.service
	systemctl daemon-reload
	systemctl enable $pkg.timer
	systemctl start $pkg.timer
done
