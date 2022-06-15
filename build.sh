#!/bin/bash

set -Eeuo pipefail
trap on_error ERR

on_error() {
  echo "Error on line $(caller): ${BASH_COMMAND}"
}

get_latest_snapraid_release() {
  # grep gets the tag_name node from the API JSON
  # sed regex extracts the version number, e.g. "12.0"
  curl --silent "https://api.github.com/repos/amadvance/snapraid/releases/latest" | \
    grep '"tag_name":' | \
    sed -E 's/.*v([^"]+)".*/\1/'
}

DOCKER_IMAGE_TAG="snapraid-build"
LATEST_RELEASE_TAG="$(get_latest_snapraid_release)"

# Uncomment BUILD_PATH if using this Dockerfile as part of an Ansible deployment
#BUILD_PATH="/tmp/build"
#mkdir $BUILD_PATH
#cd $BUILD_PATH

docker build -t "$DOCKER_IMAGE_TAG" --build-arg SNAPRAID_VERSION="${1:-$LATEST_RELEASE_TAG}" .
IMAGE_ID="$(docker create $DOCKER_IMAGE_TAG)"
docker cp "$IMAGE_ID:/build/" .
docker rm -v "$IMAGE_ID"
docker rmi "$DOCKER_IMAGE_TAG"
