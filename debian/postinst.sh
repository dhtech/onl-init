#!/usr/bin/env bash

# The Debian package will be installed very early in boot
# if it is:
#  - copied to /mnt/onl/data/install-debs/
#  - listed in /mnt/onl/data/install-debs/list
exec /usr/local/sbin/boot.sh
