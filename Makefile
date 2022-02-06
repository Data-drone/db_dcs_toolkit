.PHONY: help

SHELL:=bash

# Params for the base image and the repo to push to
BASE_IMAGE:=nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04
TAG:=cuda113
OWNER:=datadrone

help: ### Help Text
	@echo 'This tries to help to compile all the docker files in the right order'

.DEFAULT_GOAL := help

build-base:
	docker build --build-arg BASE_CONTAINER=$(BASE_IMAGE) \
	 -t $(OWNER)/dbr_packaging:gpu-minimal-$(TAG) ./minimal_container

	docker build  --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-minimal-$(TAG) \
	 -t $(OWNER)/dbr_packaging:gpu-conda-base-$(TAG) ./conda_container

	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-conda-base-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-conda-python-$(TAG) ./conda_python

build-rapids:
	docker build --build-arg BASE_CONTAINER=$(OWNER)/dbr_packaging:gpu-conda-python-$(TAG) \
     -t $(OWNER)/dbr_packaging:gpu-rapids-$(TAG) ./rapids_container

push-rapids:
	docker push $(OWNER)/dbr_packaging:gpu-rapids-$(TAG)