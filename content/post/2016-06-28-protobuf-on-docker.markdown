+++
categories = ["code", "continuous delivery", "tips"]
tags = ["python", "c", "docker"]
date = "2016-06-28T23:26:44+08:00"
description = "Compiling python's cpp_implementation in Docker_"
keywords = ["protobuf", "docker", "python", "C++", "cpp_implementation"]
title = "Protobuf on Docker"

+++

Found it really strange that nobody had mentioned on their blog how to 
compile `Protobuf` in python with **C++** implementation. 

I had been having a lot of trouble with the compilation of python protobuf. 
After struggling with it for a few months on and off I decided to give **`Docker`**
 a try as I realized that my own Fedora OS may be the one having troubles.
 Thought of starting with **Ubuntu** Docker as I've had success with it earlier
 with such compilation scripts. Luckily it all worked out successfully again
 for protobuf. 
 
Then I tried Docker for **Centos 7 and Fedora 23**, both of which had not 
 been working for me in any shape. 

The source code of the **Dockerfiles** are available on Github here:
 
 [github/abhi1010/protobuf-on-docker](https://github.com/abhi1010/protobuf-on-docker)
 
 We are running all the steps through the docker image so that the steps can be replicated 
 with any [protobuf source code release](https://github.com/google/protobuf/releases).
 
 Here's what we will be doing:
 
1. Create `protoc` compiler by compiling C++ files
2. Compile [C++ implementation for `python`]
(https://github.com/google/protobuf/tree/master/python#c-implementation) 
using the just created `protoc` 


Dockerfiles are available for the following Operating Systems:

- [Centos 7](https://github.com/abhi1010/protobuf-on-docker/blob/master/centos-7.1/Dockerfile)
- [Fedora 23](https://github.com/abhi1010/protobuf-on-docker/blob/master/fedora-23/Dockerfile)
- [Ubuntu 15](https://github.com/abhi1010/protobuf-on-docker/blob/master/ubuntu-15/Dockerfile)


## Where to find the files inside the Docker images


- `protoc` compiler is available at `/ws/protoc-3.2` folder inside the images
- `python` version (compiled from c++) is available at `/ws/protobuf-3.0.0-beta-3.2/python/dist/`

You can copy out the files using the following commands:

```bash
id=$(sudo docker create <image_name>)
sudo docker cp $id:/ws/protoc-3.2 ./
sudo docker cp $id:/ws/protobuf-3.0.0-beta-3.2/python/dist/*.gz ./
```

In case you get an error like the following, _remove_ `*.gz` from the cp command:

    zsh: no matches found: e7c8a9102e1cd07b4c471c331bc4deba2222278eb22be1e79ecaa14e914ed654:/ws/protobuf-3.0.0-beta-3.2/python/dist/*.gz
    
Your second cp command then becomes:

    sudo docker cp $id:/ws/protobuf-3.0.0-beta-3.2/python/dist/ ./

Once done, you can remove the created container with the following command:

```bash
sudo docker rm -v $id
```


Just remember to change the rights as the files will belong to `root` by default.
You can do that with the following commands:

```bash
sudo chown -R <USERNAME>:<USERNAME> *
```
