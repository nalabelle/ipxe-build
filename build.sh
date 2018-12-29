#!/bin/sh
set -ex
git clone --depth 1 https://github.com/ipxe/ipxe.git /ipxe
cd /ipxe/src
cp -av /config/local/* config/local/ || :
make -j4 "$@"
for f in bin/{ipxe.lkrn,ipxe.iso,undionly.kpxe,ipxe.pxe,ipxe.efi} "$@" ; do
    if test -r "$f" ; then
        cp "$f" /result
    fi
done
ls -l /result
