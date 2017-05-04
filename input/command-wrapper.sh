#!/bin/bash

export X509_USER_PROXY=~/.osg-koji/client.crt

get_proxy () {
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
    python -c "import os; print os.path.relpath(r'''$1''', r'''$2''')"
}

outside_wd=$1
shift

IFS=  read -r work_dir  </u/.work_dir

inside_wd=$(relpath "$outside_wd" "$work_dir")

set -e
cd ~/work
cd "$inside_wd"
get_proxy_if_needed
exec "$@"
