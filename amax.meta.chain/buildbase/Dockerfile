## create amanod buildtime env
FROM ubuntu:18.04
# install dependencies
RUN apt update && apt install -y git
RUN cd / && git clone --recursive https://github.com/armoniax/amax.meta.chain.git
WORKDIR /amax.meta.chain
ARG VER=latest

RUN FORCE_UPDATE_ID=123

RUN git pull && git checkout "tags/v${VER}"
RUN bash ./scripts/amax_build.sh -y
RUN cd ./build/packages && bash generate_package.sh deb

## create amax.meta.chain runtime env
FROM phusion/baseimage:bionic-1.0.0
ARG PUB_KEY
ARG PRIV_KEY
ARG VER=latest
ARG amc_pkg="amax_${VER}-1_amd64.deb"

RUN FORCE_UPDATE_ID=123

COPY --from=0 /amax.meta.chain/build/packages/$amc_pkg /$amc_pkg
RUN apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libicu60 libusb-1.0-0 libcurl3-gnutls
RUN apt -y install /${amc_pkg}
RUN rm -rf /${amc_pkg} && mkdir /opt/amax
WORKDIR /opt/amax
