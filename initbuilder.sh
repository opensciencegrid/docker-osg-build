#!/bin/bash

hash=$(docker ps --latest --quiet --filter name=osgbuilder)

if [[ -z $hash ]]; then
    echo -n 'creating docker image: '
    docker create -it \
                      --volume $HOME/.globus:/home/builder/.globus \
                      --volume $HOME/work:/home/builder/work \
                      --name osgbuilder \
                      matyasselmeci:osgbuilder  && \
        sleep 2
fi

docker start osgbuilder
