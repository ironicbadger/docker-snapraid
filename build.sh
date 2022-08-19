
#!/bin/bash

#set -Eeuo pipefail
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

APP_NAME="snapraid"
IMAGE_TAG="$APP_NAME-build"
LATEST_RELEASE_TAG="$(get_latest_snapraid_release)"
BUILD_ARGS="--build-arg SNAPRAID_VERSION=${1:-$LATEST_RELEASE_TAG}"

# Uncomment BUILD_PATH if using this Dockerfile as part of an Ansible deployment
#BUILD_PATH="/tmp/build"
#mkdir $BUILD_PATH
#cd $BUILD_PATH

echo "BUILD_ARGS=$BUILD_ARGS"

#docker build -o type=local,dest=./build/ $BUILD_ARGS .
docker build -t $IMAGE_TAG $BUILD_ARGS . 
ID=$(docker create $IMAGE_TAG) 
docker cp $ID:/build/ . 
docker rm -v $ID 
docker rmi $IMAGE_TAG 
