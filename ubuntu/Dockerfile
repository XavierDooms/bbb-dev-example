FROM ubuntu:26.04

ARG DEBIAN_FRONTEND=noninteractive

# Install required buildroot packages
RUN apt update && \
    apt install -y \
    gawk \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    cpio \
    diffutils \
    file \
    findutils \
    gcc \
    git \
    gzip \
    g++ \
    locales \
    make \
    patch \
    perl \
    rsync \
    sed \
    sudo \
    tar \
    unzip \
    wget

# Install optional buildroot packages
RUN apt update && \
    apt install -y \
    asciidoc \
    curl \
    dblatex \
    graphviz \
    lib32ncurses-dev \
    python3-aiohttp \
    python3-matplotlib \
    pyqt5-dev \
    w3m \
    && apt clean && \
    rm -rf /var/lib/apt/list/*

#    glade2 \
#    glib2 \
#    gtk2 \
#    qt5 \

# Install optional buildroot packages
RUN apt update && \
    apt install -y \
    gcc-arm-linux-gnueabi \
    gcc-arm-linux-gnueabihf

# ubuntu 26.04 uutils's "install" command is broken
RUN update-alternatives --install /usr/bin/install install /usr/bin/gnuinstall 100

# Buildroot requires a proper locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

# Create user and group with the same id's as host
# This prevents 
ARG UID=1000
ARG GID=1000
RUN groupmod -g $GID ubuntu && \
    usermod -u $UID ubuntu && \
    usermod -a -G sudo ubuntu

RUN install -o "${UID}" -g "${GID}" -d /workspace

COPY rootfs/ /

USER ubuntu

ENTRYPOINT /usr/local/bin/entrypoint.sh
WORKDIR /workspace
