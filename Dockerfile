FROM ubuntu:latest

RUN apt-get update && apt-get install --yes git tmux vim ruby ruby-dev build-essential tig zsh curl
RUN git clone https://github.com/jmera/dotfiles.git /root/dotfiles --verbose

WORKDIR /root/dotfiles
RUN bash -c "./install.sh"

RUN chsh -s $(which zsh)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

WORKDIR /root
