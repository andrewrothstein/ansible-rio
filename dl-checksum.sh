#!/usr/bin/env sh
VER=v0.3.2
DIR=~/Downloads
MIRROR=https://github.com/rancher/rio/releases/download/$VER
dl()
{
    OS=$1
    PLATFORM=$2

    CHECKSUMS=sha256sum-$PLATFORM.txt
    LCHECKSUMS=$DIR/rio-sha256sum-$PLATFORM-$VER.txt

    if [ ! -e $LCHECKSUMS ]
    then
        wget -q -O $LCHECKSUMS $MIRROR/$CHECKSUMS
    fi

    FILE=rio-$OS-$PLATFORM
    URL=$MIRROR/$FILE

    printf "    # %s\n" $URL
    printf "    %s-%s: sha256:%s\n" $OS $PLATFORM `fgrep $FILE $LCHECKSUMS | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl darwin amd64
dl linux amd64
dl linux arm
dl linux arm64
dl windows amd64


