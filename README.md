# Android builder for [LÖVR](https://lovr.org/)

Simple Docker based solution to compile LÖVR for Android

# How to use

Ensure you have a Java keystore ready. If you don't, look [here](https://lovr.org/docs/Compiling#creating-a-keystore)

If you have a custom version, note the location, otherwise the script can clone a version for you.

1. Clone the repo
2. Build the Docker container
```bash
docker build -t lovr-android.v2 -f androidBuilder.Dockerfile .
```
3. Check `build_commands.sh` for variables. 

    Here you set values such as folder to act upon, keystore location and password or tag to clone. 
    Tags will be cloned iff the folder is empty

4. Run `bulild_commands.sh`

This will clone the tag you chose if the folder is empty, make a build folder, load the folder and keystore into the docker container, compile and close it. 

 