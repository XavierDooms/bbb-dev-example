FROM debian:13

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
    curl \
    ncurses-dev \
    crossbuild-essential-armhf \
    && apt clean && \
    rm -rf /var/lib/apt/list/*

# Buildroot requires a proper locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

# Create user and group with the same id's as host
# This prevents 
ARG UID=1000
ARG GID=1000
RUN addgroup --gid $GID bob && \
    useradd -g bob -m -u $UID bob && \
    usermod -a -G sudo bob

RUN install -o "${UID}" -g "${GID}" -d /workspace

COPY rootfs/ /
RUN chown -R bob /home/bob

USER bob

ENTRYPOINT /usr/local/bin/entrypoint.sh
WORKDIR /workspace
