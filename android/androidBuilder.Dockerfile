FROM thyrlian/android-sdk:latest

# Install needed packages
WORKDIR /root/
RUN apt update && \
    apt install -y --no-install-recommends cmake glslang-tools g++ build-essential && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean

# Install Android SDK components
RUN yes | sdkmanager --sdk_root=/opt/android-sdk/sdk "build-tools;34.0.0" "cmake;3.22.1" "ndk;26.3.11579264" "platform-tools" "platforms;android-29"

# Keeps container running without doing anything
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

