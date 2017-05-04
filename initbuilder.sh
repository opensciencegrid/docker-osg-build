#!/bin/bash

docker create -it --volume $HOME/.globus:/home/builder/.globus \
                  --volume $HOME/work:/home/builder/work \
                  --name osgbuilder \
                  matyasselmeci:osgbuilder
