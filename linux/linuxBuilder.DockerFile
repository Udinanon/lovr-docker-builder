FROM ubuntu:jammy
# Install needed packages
# EDITS: build-essential libcurl4-openssl-dev python3-minimal vulkan-tools
RUN apt update
RUN apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    libvulkan-dev \
    clang \
    xorg-dev \
    wget \
    libcurl4-openssl-dev \
    gnupg2 \
    ca-certificates \
    libxcb-glx0-dev \
    libx11-xcb-dev

    #vulkan-utils 
    
RUN wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | tee /etc/apt/trusted.gpg.d/lunarg.asc
RUN wget -qO /etc/apt/sources.list.d/lunarg-vulkan-jammy.list https://packages.lunarg.com/vulkan/lunarg-vulkan-jammy.list
RUN apt update 

RUN apt install -y vulkan-sdk \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean

# Keeps container running without doing anything
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"