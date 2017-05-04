FROM centos:centos7

LABEL name="OSG 3.3 OSG-Build client"

RUN yum -y install https://repo.grid.iu.edu/osg/3.3/osg-3.3-el7-release-latest.rpm && \
    yum -y install epel-release \
                   yum-plugin-priorities && \
    yum -y install --enablerepo=osg-development \
                   globus-proxy-utils \
                   redhat-lsb-core \
                   osg-build && \
    groupadd u && \
    useradd -g u -G mock -m -d /u u && \
    install -d -o u -g u -m 0755 /u/.osg-koji && \
    ln -s /u/.osg-koji /u/.koji && \
    chown u:u /u/.koji

COPY input/osg-ca-bundle.crt    /u/.osg-koji/osg-ca-bundle.crt
COPY input/config               /u/.osg-koji/config
COPY input/osg-build.sh         /usr/local/bin/osg-build.sh
COPY input/osg-koji.sh          /usr/local/bin/osg-koji.sh
COPY input/utils.sh             /usr/local/libexec/utils.sh

USER u
WORKDIR /u
