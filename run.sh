#!/bin/sh

TARGET=${1:-/tmp/local/bin}
cp jq "$TARGET/jq"
cp mount.cifs "$TARGET/mount.cifs"
cp cifs.sh "$TARGET/cifs"
