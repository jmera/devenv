FROM ubuntu:disco

RUN yes | unminimize && apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install --yes \
      --no-install-recommends build-essential curl git less locales man ruby \
      ruby-dev silversearcher-ag tig vim-gtk xclip zsh && \
      rm -rf /var/lib/apt/lists/*

RUN localedef --alias-file=/usr/share/locale/locale.alias en_US.UTF-8 \
    --inputfile=en_US --force --charmap=UTF-8 && locale-gen en_US.UTF-8

ENV DISPLAY=host.docker.internal:0 LANG=en_US.utf8 TERM=xterm-256color

RUN useradd dev --create-home --shell $(which zsh)
USER dev

RUN mkdir /home/dev/workspace/ && cd /home/dev/workspace/ && \
    git clone https://github.com/jmera/dotfiles.git --verbose && \
    cd dotfiles/ && ./install

# https://github.com/robbyrussell/oh-my-zsh
RUN sh -c "$(curl -fsSL https://bit.ly/1PMPJgO)"

WORKDIR /home/dev/workspace
RUN chown -R dev:dev /home/dev
CMD zsh
