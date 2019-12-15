#!/bin/bash

# Automated build and push, using Podman.

function build_push {
    podman build --no-cache --build-arg "UMS_VERSION=$1" "$2" -t "goncalossilva/ums:$3" && \
    podman push "goncalossilva/ums:$3"
    if [[ "$4" = "latest" ]]; then
        podman tag "goncalossilva/ums:$3" "goncalossilva/ums:latest" && \
        podman push "goncalossilva/ums:latest"
        podman rmi "goncalossilva/ums:latest"
    fi
    podman rmi "goncalossilva/ums:$3"
}

if [[ ! -z "$1" ]]; then
    UMS_VERSION="$1"
else
    UMS_VERSION=`wget -qO- https://api.github.com/repos/UniversalMediaServer/UniversalMediaServer/releases/latest | python -c "import sys, json; print(json.load(sys.stdin)['name'])"`
fi
read -p "Build and push UMS $UMS_VERSION [y/N]: " -r
echo
[[ $REPLY =~ ^[Yy]$ ]] || exit -1

build_push "$UMS_VERSION" "ums" "$UMS_VERSION" "latest" &
ums_pid=$!
build_push "$UMS_VERSION" "ums-ffmpeg" "$UMS_VERSION-ffmpeg" &
ffmpeg_pid=$!
build_push "$UMS_VERSION" "ums-ffmpeg-static" "$UMS_VERSION-ffmpeg-static" &
ffmpeg_static_pid=$!

wait $ums_pid
wait $ffmpeg_pid
wait $ffmpeg_static_pid
