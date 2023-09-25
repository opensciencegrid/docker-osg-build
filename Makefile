OSG_BUILD_IMAGE ?= opensciencegrid/osg-build:latest
OSG_BUILD_REPO ?= opensciencegrid
OSG_BUILD_BRANCH ?= master
DOCKER ?= docker
SINGULARITY ?= singularity

.PHONY: all clean

all: osg_build.sif osg_build.tar

clean:
	rm -f osg_build.tar osg_build.sif

# $@ is the target; $< is the first dependency

osg_build.tar: Dockerfile input/* buildbuilder
	DOCKER="$(DOCKER)" \
	OSG_BUILD_IMAGE="$(OSG_BUILD_IMAGE)" \
	OSG_BUILD_REPO="$(OSG_BUILD_REPO)" \
	OSG_BUILD_BRANCH="$(OSG_BUILD_BRANCH)" \
		./buildbuilder
	"$(DOCKER)" save -o $@ "$(OSG_BUILD_IMAGE)"

osg_build.sif: osg_build.def osg_build.tar
	"$(SINGULARITY)" build $@ $<

