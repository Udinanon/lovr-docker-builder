# Android and Linux builder for [LÖVR](https://lovr.org/)

Docker based solution to compile LÖVR for Android and Linux systems

# How to use

If you have a custom repository to build, note its location on disk

If you only want to reproduce an existing version, note the tag 

Clone the repo to any location

Then choose what platform you want to start with

## Linux 


1. Build the Docker container
```bash
docker build -t lovr_linux.v2 -f linux/linuxBuilder.Dockerfile .
```
1. Check `build_linux.sh` for variables. 

    Here you set values such as folder of your code or if it's a debug build. 
    Tags will be cloned iff the folder is empty

2. Run `build_linux.sh`

## Android 

Ensure you have a Java keystore ready. If you don't, look [here](https://lovr.org/docs/Compiling#creating-a-keystore)

1. Build the Docker container
```bash
docker build -t lovr_android.v2 -f android/androidBuilder.Dockerfile .
```
1. Check `build_android.sh` for variables. 

    Here you set values such as folder of your code, keystore location and password or tag to clone. 
    Tags will be cloned iff the folder is empty

2. Run `build_android.sh`

This will clone the tag you chose if the folder is empty, make a build folder, load the folder and keystore into the docker container, compile and close it. 

# What about other platforms?

Neither Windows nor macOS are capable of running within a Linux container, so they're not as easy

I'm thinking of trying to use [docker-QEMU](https://github.com/gnh1201/docker-qemu/wiki/Windows-Guest) for windows, and macOS has [Docker-OSX](https://github.com/sickcodes/Docker-OSX), but moth are a different design altogether, relying on a VM running inside a QEMU container.

This would be a lot slower, bigger, more complex to setup and use, and I'm not even sure it can be automated the same way. 
Also, installing their requirements is a lot more than "using docker".

If you want to try do tell me about it tho