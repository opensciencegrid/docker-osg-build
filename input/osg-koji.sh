#!/bin/bash

proxy_file=~/.osg-koji/client.crt

get_proxy () {
    grid-proxy-init -out "$proxy_file"
}

get_proxy_if_needed () {
    if [[ ! -f $proxy_file ]]; then
        get_proxy
        return
    fi

    timeleft=$(grid-proxy-info -timeleft -file "$proxy_file")
    ret=$?

    if [[ $ret -ne 0 || $timeleft -lt 60 ]]; then
        get_proxy
    fi
}

get_proxy_if_needed
exec osg-koji "$@"
