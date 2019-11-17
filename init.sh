#!/bin/bash
#
# called by unshare to mount a new root filesystem
# then pivot_root to it and unmount the old one.
# Also mount proc/ in the process
#
# usage:
#
#  $ unshare --user --map-root-user --mount --fork --pid ./init.sh
#
# Note: in a Debian system you must set
#       # sysctl -w kernel.unprivileged_userns_clone=1

set -o nounset
set -o errexit
# set -x

mount --bind rootfs rootfs
mount -t proc proc rootfs/proc
cd rootfs/
mkdir put_old
/sbin/pivot_root . put_old
cd /
umount -l put_old/ && rmdir put_old

exec sh
