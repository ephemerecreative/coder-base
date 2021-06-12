FROM ubuntu:20.04

# Install baseline packages
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    unzip \
    htop \
    man \
    vim \
    sudo \
    python3 \
    python3-pip \
    ca-certificates \
    locales \
    zsh

# Set default shell to zsh
RUN chsh -s /usr/bin/zsh

# Add a user `coder` so that you're not developing as the `root` user
RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
USER coder
WORKDIR /home/coder

COPY scripts/configure-prezto.sh /tmp/configure-prezto.sh
RUN zsh /tmp/configure-prezto.sh
COPY assets/.zpreztorc /home/coder/.zprezto/runcoms/zpreztorc

COPY scripts/config.sh /tmp/config.sh
RUN zsh /tmp/config.sh