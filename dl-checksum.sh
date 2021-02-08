#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/rancher/rio/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3

    local checksums=sha256sum-$arch.txt
    local lchecksums=$DIR/rio-sha256sum-$arch-$ver.txt

    if [ ! -e $lchecksums ]
    then
        wget -q -O $lchecksums $MIRROR/$ver/$checksums
    fi

    local file=rio-$os-$arch
    local url=$MIRROR/$ver/$file

    printf "    # %s\n" $url
    printf "    %s-%s: sha256:%s\n" $os $arch `fgrep $file $lchecksums | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver darwin amd64
    dl $ver linux amd64
    dl $ver linux arm
    dl $ver linux arm64
    dl $ver windows amd64
}

dl_ver ${1:-v0.8.0}
