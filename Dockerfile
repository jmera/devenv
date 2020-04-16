FROM ubuntu:bionic
MAINTAINER "Julich Mera <julich.mera@gmail.com>"
ARG DEBIAN_FRONTEND=noninteractive

RUN yes | unminimize && \
  apt-get update && \
  apt-get install --yes --no-install-recommends \
    build-essential \
    curl \
    git \
    less \
    locales \
    man \
    ruby \
    ruby-dev \
    silversearcher-ag \
    ssh \
    tig \
    vim-gtk \
    xclip \
    zsh && \
  rm -rf /var/lib/apt/lists/*

RUN localedef \
    --alias-file=/usr/share/locale/locale.alias en_US.UTF-8 \
    --charmap=UTF-8 \
    --force \
    --inputfile=en_US && \
  locale-gen en_US.UTF-8

RUN chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight && \
  ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/bin/

ENV DISPLAY=host.docker.internal:0 LANG=en_US.utf8 TERM=xterm-256color

RUN useradd dev --create-home --shell $(which zsh)
USER dev
RUN cd /home/dev/ && \
  git clone --verbose https://github.com/jmera/dotfiles.git .dotfiles/ && \
  cd .dotfiles/ && \
  ./install

# https://github.com/robbyrussell/oh-my-zsh
RUN sh -c "$(curl -fsSL https://bit.ly/1PMPJgO)"

RUN mkdir /home/dev/workspace/ && \
  chown -R dev:dev /home/dev
WORKDIR /home/dev/
ENTRYPOINT ["/usr/bin/zsh"]
