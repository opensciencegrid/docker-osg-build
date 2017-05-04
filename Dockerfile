FROM matyasselmeci:osgbuilderbase

LABEL name="OSG 3.3 OSG-Build client"

RUN groupadd u && \
    useradd -g u -G mock -m -d /u u && \
    install -d -o u -g u -m 0755 /u/.osg-koji && \
    ln -s /u/.osg-koji /u/.koji && \
    chown u:u /u/.koji

COPY input/osg-ca-bundle.crt    /u/.osg-koji/osg-ca-bundle.crt
COPY input/config               /u/.osg-koji/config
COPY input/command-wrapper.sh   /usr/local/bin/command-wrapper.sh

USER u
WORKDIR /u
