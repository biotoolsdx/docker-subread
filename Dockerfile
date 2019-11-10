FROM ubuntu:16.04
MAINTAINER Chen Yuelong <yuelong.chen.btr@gmail.com>

ARG subread_version=1.6.2
ARG BUILD_PACKAGES="build-essential wget zlib1g-dev"
ARG DEBIAN_FRONTEND=noninteractive




# Update the repository sources list
RUN apt-get update && \
    apt-get install --yes \
              $BUILD_PACKAGES && \
    cd /tmp && \
    wget -q https://downloads.sourceforge.net/project/subread/subread-${subread_version}/subread-${subread_version}-source.tar.gz && \
    tar -xzf subread-${subread_version}-source.tar.gz && \
    cd subread-${subread_version}-source/src && \
    make -f Makefile.Linux && \
    cd ../bin && \
    mv utilities/* . && \
    rmdir utilities && \
    mv * /usr/local/bin/ && \
    cd / && \
    rm -rf /tmp/* && \
    apt remove --purge --yes \
              $BUILD_PACKAGES && \
    apt autoremove --purge --yes && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD bash