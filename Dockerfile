FROM ubuntu:latest

ENV LC_ALL=en_US.UTF-8
RUN apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install --yes \
        build-essential \
        curl \
        git \
        man \
        ruby \
        ruby-dev \
        tig \
        tmux \
        vim-nox \
        zsh

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
