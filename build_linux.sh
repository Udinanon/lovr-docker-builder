#!/usr/bin/sh
set -e
PROJECT_PATH=/home/udinanon/Programming/Projects/LOVR/misc/compile-test # Your code folder
CONTAINER_NAME=lovr_linux:v3 # The name of the built docker continer
BRANCH_TAG=v0.17.1 # If folder empty, version to clone and compile
BUILD_TYPE=Release # Change to make debug build

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
DOCKER_NAME=linux_builder
docker run -d --name ${DOCKER_NAME} -v ${PROJECT_PATH}:/root/code -w /root/code/build ${CONTAINER_NAME}

# Step 3: launch compialtion
docker exec ${DOCKER_NAME} cmake -D CMAKE_BUILD_TYPE=${BUILD_TYPE} ..
docker exec ${DOCKER_NAME} cmake --build . -j"$(nproc)"

# Step 4: close docker
docker stop ${DOCKER_NAME} 
docker rm ${DOCKER_NAME}
