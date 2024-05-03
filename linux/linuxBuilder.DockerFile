FROM ubuntu:jammy
# Install needed packages
# Added from docs: build-essential libcurl4-openssl-dev libxcb-glx0-dev libx11-xcb-dev glslang-tools     python3-minimal 
RUN apt update
RUN apt-get install -y --no-install-recommends \
    make \
    cmake \
    python3-minimal \
    clang \
    xorg-dev \
    libcurl4-openssl-dev \
    libxcb-glx0-dev \ 
    libx11-xcb-dev \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean

    # Set Compilers for CMake
ENV CC=/usr/bin/clang
ENV CXX=/usr/bin/clang++

# Keeps container running without doing anything
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"