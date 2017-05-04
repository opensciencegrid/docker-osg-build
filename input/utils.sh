export X509_USER_PROXY=~/.osg-koji/client.crt

get_proxy () {
    grid-proxy-init -out "$X509_USER_PROXY"
}

get_proxy_if_needed () {
    if [[ ! -f $proxy_file ]]; then
        get_proxy
        return
    fi

    timeleft=$(grid-proxy-info -timeleft -file "$X509_USER_PROXY")
    ret=$?

    if [[ $ret -ne 0 || $timeleft -lt 60 ]]; then
        get_proxy
    fi
}

