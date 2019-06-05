FROM ubuntu:disco

ENV DISPLAY=host.docker.internal:0 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm-256color
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
      tmux \
      vim-gtk \
      zsh
RUN locale-gen en_US.UTF-8

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
CMD tmux
