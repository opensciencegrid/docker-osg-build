FROM centos:centos7

LABEL name="OSG 3.3 OSG-Build client"

RUN yum -y install https://repo.grid.iu.edu/osg/3.3/osg-3.3-el7-release-latest.rpm && \
    yum -y install epel-release \
                   yum-plugin-priorities && \
    yum -y install --enablerepo=osg-development \
                   globus-proxy-utils \
                   redhat-lsb-core \
                   osg-build && \
    groupadd builder && \
    useradd -g builder -G mock -m builder && \
    ln -s /home/builder/.osg-koji /home/builder/.koji

COPY osg-build-inside.sh  /usr/local/bin/osg-build-inside.sh
COPY osg-koji-inside.sh /usr/local/bin/osg-koji-inside.sh

USER builder
WORKDIR /home/builder
