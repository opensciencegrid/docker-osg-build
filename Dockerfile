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
    install -d -o builder -g builder -m 0755 /home/builder/.osg-koji && \
    ln -s /home/builder/.osg-koji /home/builder/.koji && \
    chown builder:builder /home/builder/.koji

COPY input/osg-ca-bundle.crt    /home/builder/.osg-koji/osg-ca-bundle.crt
COPY input/config               /home/builder/.osg-koji/config
COPY input/osg-build.sh  /usr/local/bin/osg-build.sh
COPY input/osg-koji.sh   /usr/local/bin/osg-koji.sh

USER builder
WORKDIR /home/builder
