FROM ubuntu:26.04

ARG DEBIAN_FRONTEND=noninteractive

# Install required yocto packages
RUN apt update && \
    apt install -y \
    build-essential \
    chrpath \
    cpio \
    debianutils \
    diffstat \
    file \
    gawk \
    gcc \
    git \
    iputils-ping \
    libacl1 \
    libcrypt-dev \
    locales \
    python3 \
    python3-git \
    python3-jinja2 \
    python3-pexpect \
    python3-pip \
    python3-subunit \
    python3-venv \
    python3-websockets \
    socat \
    sudo \
    texinfo \
    unzip \
    wget \
    xz-utils \
    zstd && \
    apt clean && \
    rm -rf /var/lib/apt/list/*

# Yocto requires a UTF8 locale (en_US.UTF-8 recommended)
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
