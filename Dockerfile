FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    build-essential \
    curl \
    wget \
    jq \
    unzip \
    htop \
    man \
    vim \
    sudo \
    python3 \
    python3-pip \
    php \
    ca-certificates \
    locales \
    postgresql-client \
    mysql-client \
    zsh \
    fish

RUN apt-get install -y software-properties-common && \
    apt-get update && \
    add-apt-repository ppa:git-core/ppa -y && \
    apt-get update && \
    sudo apt install git -y

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

RUN chsh -s $(which zsh) $(whoami)

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


## USER: CODER

RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

RUN chsh -s $(which zsh) coder

USER coder

RUN sudo chown -R coder /home/linuxbrew/.linuxbrew/Cellar

WORKDIR /home/coder

COPY home /coder/home
COPY scripts/configure /coder/configure