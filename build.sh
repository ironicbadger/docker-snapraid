#!/bin/bash
APP_NAME="snapraid"
IMAGE_TAG="$APP_NAME-build"

# Uncomment BUILD_PATH if using this Dockerfile as part of an Ansible deployment
#BUILD_PATH="/tmp/build"
#mkdir $BUILD_PATH
#cd $BUILD_PATH

BUILD_ARGS=""
[[ -z ${1} ]] || BUILD_ARGS="--build-arg SNAPRAID_VERSION=$1"
echo BUILD_ARGS=$BUILD_ARGS

docker build -t $IMAGE_TAG $BUILD_ARGS .
ID=$(docker create $IMAGE_TAG)
docker cp $ID:/build/ .
docker rm -v $ID
docker rmi $IMAGE_TAG
