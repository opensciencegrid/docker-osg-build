#!/bin/bash

export X509_USER_PROXY=~/.osg-koji/client.crt

get_proxy () {
    #voms-proxy-init -out "$X509_USER_PROXY"
    # ^^ gives me "verification failed"
    grid-proxy-init -out "$X509_USER_PROXY"
}

get_proxy_if_needed () {
    if [[ ! -f $X509_USER_PROXY ]]; then
        get_proxy
        return
    fi

    timeleft=$(grid-proxy-info -timeleft -file "$X509_USER_PROXY")
    ret=$?

    if [[ $ret -ne 0 || $timeleft -lt 60 ]]; then
        get_proxy
    fi
}

relpath () {
    python3 -c "import os,sys; print(os.path.relpath(sys.argv[1], sys.argv[2]))" "$1" "$2"
}

outside_wd=$1
shift

IFS=  read -r work_dir  </home/build/.work_dir

inside_wd=$(relpath "$outside_wd" "$work_dir")

set -e
if [[ $1 = osg-build ]]; then
    cd ~/work
    if [[ $inside_wd = ../* ]]; then
        echo >&2 "The current directory is '$outside_wd'"
        echo >&2 "which is not under the work directory '$work_dir'"
        echo >&2 "osg-build commands must be run under the work directory"
        exit 2
    fi
    cd "$inside_wd"
fi
get_proxy_if_needed
exec "$@"
