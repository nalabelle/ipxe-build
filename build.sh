#!/bin/bash
set -e -x
find /result -type f | xargs rm -fv
cd /ipxe/src
cp -av /config/* config/local/
make -j4 "$@"
for f in bin/{ipxe.lkrn,ipxe.iso,undionly.kpxe,ipxe.pxe} "$@" ; do
    if test -r "$f" ; then
        cp "$f" /result
    fi
done
chown --reference /result --recursive /result
ls -l /result
