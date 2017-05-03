#!/bin/bash

docker exec -it osgbuilder \
    /usr/local/bin/osg-build-inside.sh "$@"
