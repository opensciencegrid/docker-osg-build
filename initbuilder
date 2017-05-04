#!/bin/bash

die () {
    echo "$@" 1>&2
    exit 1
}

[[ -r $HOME/.globus/usercert.pem ]] || die "~/.globus/usercert.pem not found or not readable"
[[ -r $HOME/.globus/userkey.pem ]] || die "~/.globus/userkey.pem not found or not readable"

work_dir=~/work

[[ -x $work_dir ]] || die "$work_dir not found or not readable"


set -eu

hash=$(docker ps --latest --quiet --filter name=osgbuilder)

if [[ -z $hash ]]; then
    echo -n 'creating docker image: '
    docker create -it \
                      --volume $HOME/.globus:/home/builder/.globus \
                      --volume "$work_dir":/home/builder/work \
                      --name osgbuilder \
                      matyasselmeci:osgbuilder  && \
        sleep 2
fi

docker start osgbuilder
