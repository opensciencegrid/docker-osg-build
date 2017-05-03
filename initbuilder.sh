#!/bin/bash

docker create -it --volume $HOME/.globus:/home/builder/.globus \
                  --volume $HOME/.osg-koji:/home/builder/.osg-koji \
                  --volume $HOME/work:/home/builder/work \
                  --name osgbuilder \
                  osgbuilder
