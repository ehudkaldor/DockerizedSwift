#!/bin/sh

# cleaning up previous builds
echo "deleting older results folders"
rm -rf ./swift_builder_*

#capture time for consistent naming
MY_TIME=`date +%s`
RESULTS_ROOT="swift_builder_$MY_TIME"
OUTPUT_DIR="$RESULTS_ROOT/site-packages"
echo "MY_TIME: $MY_TIME"
echo "OUTPUT_DIR: $OUTPUT_DIR"
# export VERSION=":$MY_TIME"

# create dir for temporary stuff

mkdir -p $OUTPUT_DIR

# build base builder image to refresh
echo "building base builder image"
docker build -t builder:$MY_TIME -f Dockerfile.builder . &> $RESULTS_ROOT/build.log
echo "builder image done"

# build xattr container and grab it
echo "building xattr"
docker build --build-arg VERSION=$MY_TIME -t xattr:$MY_TIME -f Dockerfile.buildxattr . &> $RESULTS_ROOT/build.log
docker run -d --rm --name xattr$MY_TIME xattr:$MY_TIME ping localhost &> $RESULTS_ROOT/build.log
docker cp xattr$MY_TIME:/opt/mount/ $OUTPUT_DIR/ &> $RESULTS_ROOT/build.log
docker kill xattr$MY_TIME &> $RESULTS_ROOT/build.log
echo "acquired xattr"

# build libErasureCode for pyeclib
echo "building libErasureCode (for pyECLib)"
docker build --build-arg VERSION=$MY_TIME -t liberasurecode:$MY_TIME -f Dockerfile.buildLibErasureCode . &> $RESULTS_ROOT/build.log
docker run -d --rm --name liberasurecode$MY_TIME liberasurecode:$MY_TIME ping localhost &> $RESULTS_ROOT/build.log
echo "completed libErasureCode"

# build pyeclib container and grab it
echo "building pyeclib"
docker build --build-arg VERSION=$MY_TIME -t pyeclib:$MY_TIME -f Dockerfile.buildPyECLib . &> $RESULTS_ROOT/build.log
docker run -d --rm --name pyeclib$MY_TIME pyeclib:$MY_TIME ping localhost &> $RESULTS_ROOT/build.log
docker cp pyeclib$MY_TIME:/opt/mount/ $OUTPUT_DIR/ &> $RESULTS_ROOT/build.log
docker kill pyeclib$MY_TIME &> $RESULTS_ROOT/build.log
echo "acquired pyeclib"
