#!/usr/bin/sh

CMAKE_PATH=/opt/android-sdk/sdk/ndk/21.4.7075529/build/cmake/android.toolchain.cmake
BUILD_TYPE=Release # Change to make debug build

# Switch to build folder
cd /root/code/build || { echo "inital cd failed"; exit 127; }
cmake \
    -D CMAKE_TOOLCHAIN_FILE=${CMAKE_PATH} \
    -D ANDROID_SDK=/opt/android-sdk/sdk/ \
    -D ANDROID_ABI=arm64-v8a \
    -D ANDROID_NATIVE_API_LEVEL=29 \
    -D ANDROID_BUILD_TOOLS_VERSION=34.0.0 \
    -D ANDROID_KEYSTORE=/root/keys.keystore \
    -D ANDROID_KEYSTORE_PASS=pass:"${KEYSTORE_PASS}" \
    -D CMAKE_BUILD_TYPE=${BUILD_TYPE} \
    ..
cmake --build .