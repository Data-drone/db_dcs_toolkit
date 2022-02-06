ARG BASE_CONTAINER
# can be ubuntu:18.04 or an nvidia gpu one
# like nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04

FROM $BASE_CONTAINER

ENV DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC

# copied as per https://github.com/databricks/containers/blob/master/ubuntu/minimal/Dockerfile
# Can also maybe switch openjdk to zulu to match DBR 10.x runtimes? 
# added g++ and unixodbc for connection to third party dbs
RUN apt-get update \
  && apt-get install --yes \
    openjdk-8-jdk \
    iproute2 \
    bash \
    sudo \
    coreutils \
    procps \
    wget \
    g++ \
    unixodbc-dev \
  && /var/lib/dpkg/info/ca-certificates-java.postinst configure \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*