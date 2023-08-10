ARG EL=al8
ARG OSG=3.6
FROM hub.opensciencegrid.org/opensciencegrid/software-base:$OSG-$EL-development
ARG EL
ARG OSG
ARG LOCALE=C.UTF-8

LABEL name="osg-build"
LABEL maintainer="OSG Software <help@osg-htc.org>"

ENV LANG=$LOCALE
ENV LC_ALL=$LOCALE

ADD osg-3.6-build.repo /etc/yum.repos.d/

RUN --mount=type=cache,target=/var/cache,sharing=locked \
  yum -y install --enablerepo=osg-3.6-build --enablerepo=devops-itb \
    buildsys-macros \
    buildsys-build \
    buildsys-srpm-build \
    voms-clients \
    osg-build-deps

RUN groupadd build
RUN useradd -g build -G mock -m -d /home/build build
RUN install -d -o build -g build -m 0755 /home/build/.osg-koji
RUN ln -s .osg-koji /home/build/.koji
RUN chown build: /home/build/.koji

COPY input/osg-ca-bundle.crt    /home/build/.osg-koji/osg-ca-bundle.crt
COPY input/config               /home/build/.osg-koji/config
COPY input/command-wrapper.sh   /usr/local/bin/command-wrapper.sh
COPY input/mock.cfg             /etc/mock/site-defaults.cfg
COPY input/build-from-github    /usr/local/bin/build-from-github

USER build
WORKDIR /home/build
