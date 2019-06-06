FROM ubuntu:disco

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes \
      build-essential \
      curl \
      git \
      locales \
      man \
      ruby \
      ruby-dev \
      silversearcher-ag \
      tig \
      vim-gtk \
      zsh
RUN rm -rf /var/lib/apt/lists/*
RUN localedef --inputfile=en_US --force --charmap=UTF-8 --alias-file=/usr/share/locale/locale.alias en_US.UTF-8
RUN locale-gen en_US.UTF-8

ENV DISPLAY=host.docker.internal:0 \
    LANG=en_US.utf8 \
    TERM=xterm-256color

RUN useradd dev --create-home --shell $(which zsh)
USER dev
RUN mkdir /home/dev/workspace/ && \
    cd /home/dev/workspace/ && \
    git clone https://github.com/jmera/dotfiles.git --verbose && \
    cd dotfiles/ && \
    bash -c "./install.sh"
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

WORKDIR /home/dev/workspace
RUN chown -R dev:dev /home/dev
CMD zsh
