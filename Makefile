.PHONY: help

SHELL:=bash

# Params for the base image and the repo to push to
BASE_IMAGE:=nvidia/cuda:11.5.1-cudnn8-runtime-ubuntu20.04
TAG:=cuda115
OWNER:=datadrone

help: ### Help Text
	@echo 'This tries to help to compile all the docker files in the right order'

.DEFAULT_GOAL := help

build-base:
	docker build --build-arg BASE_CONTAINER=$(BASE_IMAGE) \
	 -t $(OWNER)/dbr_packaging:gpu-minimal-$(TAG) ./minimal_container

#	docker build  --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-minimal-$(TAG) \
	 -t $(OWNER)/dbr_packaging:gpu-conda-base-$(TAG) ./conda_container

	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-minimal-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-conda-python-$(TAG) ./conda_python

	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-conda-python-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-dbfsfuse-$(TAG) ./dbfsfuse

	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-dbfsfuse-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-standard-$(TAG) ./standard

	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-standard-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-r-$(TAG) ./R

build-rapids:
	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-r-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-rapids-$(TAG) ./rapids_container

build-ganglia:
	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-rapids-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-rapids-ganglia-$(TAG) ./ganglia

push-rapids:
	docker push $(OWNER)/dbr_packaging:gpu-rapids-$(TAG)

build-fullml:
	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-rapids-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-fullml-$(TAG) ./full_ml_container