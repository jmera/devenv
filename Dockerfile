FROM ubuntu:latest

ENV LC_ALL=en_US.UTF-8
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

RUN useradd dev --create-home --shell $(which zsh)
USER dev

ENV DOTFILES_DIR=/home/dev/workspace/dotfiles
RUN git clone https://github.com/jmera/dotfiles.git $DOTFILES_DIR --verbose
WORKDIR $DOTFILES_DIR
RUN bash -c "./install.sh"

WORKDIR /home/dev/
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

RUN chown -R dev:dev /home/dev
