ARG BASE_CONTAINER
# can be ubuntu:18.04 or an nvidia gpu one
# like nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04

FROM $BASE_CONTAINER

RUN apt-get update \
  && apt-get install -y openssh-server \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Warning: the created user has root permissions inside the container
# Warning: you still need to start the ssh process with `sudo service ssh start`
RUN useradd --create-home --shell /bin/bash --groups sudo ubuntu