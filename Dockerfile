FROM centos:7

LABEL maintainer="OSG Software <help@opensciencegrid.org>"
LABEL name="OSG 3.5 OSG-Build client"

RUN yum -y install https://repo.opensciencegrid.org/osg/3.5/osg-3.5-el7-release-latest.rpm \
                   epel-release \
                   yum-plugin-priorities && \
    # Install packages included in the Koji build repos
    yum -y install --enablerepo=osg-development \
                   --enablerepo=devops-itb \
                   epel-rpm-macros \
                   tar \
                   sed \
                   findutils \
                   gcc \
                   redhat-rpm-config \
                   make \
                   shadow-utils \
                   coreutils \
                   buildsys-macros \
                   which \
                   gcc-c++ \
                   unzip \
                   gawk \
                   cpio \
                   bash \
                   info \
                   grep \
                   rpm-build \
                   patch \
                   util-linux-ng \
                   diffutils \
                   gzip \
                   redhat-release \
                   bzip2 \
                   globus-proxy-utils \
                   redhat-lsb-core \
                   rpmdevtools \
                   osg-build && \
    yum clean all --enablerepo=\* && \
    rm -rf /var/cache/yum/* && \
    rpm -qa | sort > /rpms.txt

RUN groupadd u && \
    useradd -g u -G mock -m -d /u u && \
    install -d -o u -g u -m 0755 /u/.osg-koji && \
    ln -s /u/.osg-koji /u/.koji && \
    chown u:u /u/.koji

COPY input/osg-ca-bundle.crt    /u/.osg-koji/osg-ca-bundle.crt
COPY input/config               /u/.osg-koji/config
COPY input/command-wrapper.sh   /usr/local/bin/command-wrapper.sh
COPY input/mock.cfg             /etc/mock/site-defaults.cfg
COPY input/build-from-github    /usr/local/bin/build-from-github

USER u
WORKDIR /u
