#!/usr/bin/env sh
VER=${1:-v0.5.0}
DIR=~/Downloads
MIRROR=https://github.com/rancher/rio/releases/download/$VER

dl()
{
    local os=$1
    local arch=$2

    local checksums=sha256sum-$arch.txt
    local lchecksums=$DIR/rio-sha256sum-$arch-$VER.txt

    if [ ! -e $lchecksums ]
    then
        wget -q -O $lchecksums $MIRROR/$checksums
    fi

    local file=rio-$os-$arch
    local url=$MIRROR/$file

    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch `fgrep $file $lchecksums | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl darwin amd64
dl linux amd64
dl linux arm
dl linux arm64
dl windows amd64


