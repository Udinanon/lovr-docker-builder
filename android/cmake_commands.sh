#!/usr/bin/sh

CMAKE_PATH=/opt/android-sdk/sdk/ndk/26.3.11579264/build/cmake/android.toolchain.cmake
BUILD_TYPE=debug # Change to make debug build
CODE_PATH=/root/code
# Switch to build folder
if [ ! -d "${CODE_PATH}/build" ]; then
    echo "Creating build folder."
    mkdir "${CODE_PATH}/build"
fi

cd /root/code/build || { echo "inital cd failed"; exit 127; }
cmake \
    -D CMAKE_TOOLCHAIN_FILE=${CMAKE_PATH} \
    -D ANDROID_SDK=/opt/android-sdk/sdk/ \
    -D ANDROID_ABI=arm64-v8a \
    -D ANDROID_STL=c++_shared \
    -D ANDROID_NATIVE_API_LEVEL=29 \
    -D ANDROID_BUILD_TOOLS_VERSION=34.0.0 \
    -D ANDROID_KEYSTORE=/root/keys.keystore \
    -D ANDROID_KEYSTORE_PASS=pass:"${KEYSTORE_PASS}" \
    -D CMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -D ANDROID_MANIFEST="${CODE_PATH}/etc/AndroidManifest.xml" \
    ..
cmake --build .