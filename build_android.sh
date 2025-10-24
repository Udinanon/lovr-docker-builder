#!/usr/bin/sh
set -e # fail on any command error
set -u # fail on unset vairables
set -o pipefail # pass the failing command error instead of the last one

# VARIABLES
PROJECT_PATH=/home/udinanon/Programming/Projects/LOVR/misc/compile-test # Your code folder
CONTAINER_NAME=lovr_android:v3 # The name of the built docker container
KEYSTORE_PATH=/home/udinanon/Programming/Projects/LOVR/misc/lovr_keys.keystore # Your keystore
KEYSTORE_PASS=vrjams # Keystore password
BRANCH_TAG=v0.16.0 # If folder empty, version to clone and compile

# Step 1: prepare folder
echo "${PROJECT_PATH} as target folder"
if [ "$(ls -A ${PROJECT_PATH})" ]; then
    echo "Folder not empty, compiling on it"
else 
    echo "Folder empty, cloning target version inside first"
    git clone --depth 1 --branch  ${BRANCH_TAG} --single-branch --recurse-submodules --shallow-submodules https://github.com/bjornbytes/lovr.git ${PROJECT_PATH}
fi

# Step 2: load Docker
FOLDER_NAME=$(basename "$PROJECT_PATH") # Extrasct last folder name from path, so works both with branch tags and a custom folder
DOCKER_NAME="${FOLDER_NAME}_android_builder"
docker run -d --name ${DOCKER_NAME} -v ${PROJECT_PATH}:/root/code -w /root/ ${CONTAINER_NAME}
docker cp ${KEYSTORE_PATH} ${DOCKER_NAME}:/root/keys.keystore
docker cp ./android/cmake_commands.sh ${DOCKER_NAME}:/root/cmake_commands.sh

# Step 3: launch compialtion
docker exec -e KEYSTORE_PASS=${KEYSTORE_PASS} ${DOCKER_NAME} /root/cmake_commands.sh 

# Step 4: close docker
docker stop ${DOCKER_NAME} 
docker rm ${DOCKER_NAME}