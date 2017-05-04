#!/bin/bash

docker exec -it osgbuilder \
    /usr/local/bin/osg-koji-inside.sh "$@"
