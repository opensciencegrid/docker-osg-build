get_proxy_if_needed () {
    timeleft=$(grid-proxy-info -timeleft -file ~/.osg-koji/client.crt)
    ret=$?

    if [[ $ret -ne 0 || $timeleft -lt 60 ]]; then
        grid-proxy-init -out ~/.osg-koji/client.crt
    fi
}
