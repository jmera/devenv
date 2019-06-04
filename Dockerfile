FROM ubuntu:latest

RUN apt-get update && \
      apt-get install --yes \
        build-essential \
        curl \
        git \
        man \
        ruby \
        ruby-dev \
        tig \
        tmux \
        vim \
        zsh

RUN useradd dev --create-home \
                --home-dir /home/dev/ \
                --shell $(which zsh) \
                --gid root \
                --groups sudo
USER dev
RUN git clone https://github.com/jmera/dotfiles.git /home/dev/dotfiles --verbose

WORKDIR /home/dev/dotfiles/
RUN bash -c "./install.sh"

WORKDIR /home/dev/
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
