#!/usr/bin/sh
set -e # fail on any command error

# VARIABLES
PROJECT_PATH=/home/udinanon/Programming/Projects/LOVR/misc/compile-test # Your code folder
CONTAINER_NAME=lovr_android:v2 # The name of the built docker continer
KEYSTORE_PATH=/home/udinanon/Programming/Projects/LOVR/misc/lovr_keys.keystore # Your keystore
KEYSTORE_PASS=vrjams # Keystore password
BRANCH_TAG=v0.16.0 # If folder empty, version to clone and compile

# Step 1: prepare folder
echo "${PROJECT_PATH} as target folder"
if [ "$(ls -A ${PROJECT_PATH})" ]; then
    echo "Folder not empty, compiling on it"
    cd ${PROJECT_PATH} 

else 
    echo "Folder empty, cloning target version inside first"
    cd ${PROJECT_PATH}
    git clone --depth 1 --branch  ${BRANCH_TAG} --single-branch --recurse-submodules --shallow-submodules https://github.com/bjornbytes/lovr.git .
fi

if [ ! -d "${PROJECT_PATH}/build" ]; then
    echo "Creating build folder."
    mkdir build
fi

cd ${PROJECT_PATH}/build

# Step 2: load Docker
DOCKER_NAME=android_builder
docker run -d --name ${DOCKER_NAME} -v ${PROJECT_PATH}:/root/code -w /root/ ${CONTAINER_NAME}
docker cp ${KEYSTORE_PATH} ${DOCKER_NAME}:/root/keys.keystore
docker cp android/cmake_commands.sh ${DOCKER_NAME}:/root/cmake_commands.sh

# Step 3: launch compialtion
docker exec -e KEYSTORE_PASS=${KEYSTORE_PASS} ${DOCKER_NAME} /root/cmake_commands.sh 

# Step 4: close docker
docker stop ${DOCKER_NAME} 
docker rm ${DOCKER_NAME}