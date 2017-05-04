#!/bin/bash

work_dir=~/Documents/work

relpath=$(python -c "import os; print os.path.relpath(r'''$(pwd -P)''', os.path.expanduser('''${work_dir}'''))")

docker exec -it osgbuilder \
    /bin/bash -c 'cd "/u/work/'$relpath'" && /usr/local/bin/osg-koji.sh "$@"' osg-koji "$@"
