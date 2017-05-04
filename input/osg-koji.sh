#!/bin/bash

. /usr/local/libexec/utils.sh

get_proxy_if_needed
exec osg-koji "$@"
