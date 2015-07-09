#!/bin/bash

#builder image
builder=so0k/mount.cifs_builder

#final image
final=so0k/mount.cifs_copy

#build builder & feed context to target image
#see https://github.com/jamiemccrindle/dockerception

docker build -f builder.Dockerfile -t $builder . && docker run $builder | docker build -t $final -