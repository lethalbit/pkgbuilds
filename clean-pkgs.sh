#!/bin/bash

find /srv/http/pkg.catgirl.link/*.tar.xz -mtime +5 -exec rm {} \;
find /srv/http/pkg.catgirl.link/*.tar.xz.sig -mtime +5 -exec rm {} \;
find /srv/http/pkg.catgirl.link/*.tar.xz.sha256 -mtime +5 -exec rm {} \;
