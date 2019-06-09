# devenv
My development environment in Docker

# Motivation
I love Docker; it's immutable, predictable, reproducible, and portable. Unfortunately development using Docker on macOS/Windows is a nightmare because bind mounts are notoriously slow. If you've every worked on a moderately-sized application using Docker you've felt this pain. I've tried everything from selective bind mounts, to NFS mounts, to docker-sync and nothing has quite worked the way I want it to.

So one day I decided to get rid of bind mounts completely by moving my entire development environment to Docker. This issues that exist in macOS/Windows don't apply to you if you do everything inside Docker's Linux VM.

# Requirements
- [Docker](https://docs.docker.com/install/)
- Git

# Dev Tools
- git
- vim
- tig
- zsh
- oh-my-zsh

# Usage
Clone the repo, docker-compose up

```zsh
$ git clone git@github.com:jmera/devenv.git
# if you prefer HTTP: https://github.com/jmera/devenv.git
$ cd devenv
$ docker-compose up --detach
```

All work should go in your workspace (also the default working directory): `/home/dev/workspace/`. Changes made here will be persisted between runs in a volume named `devenv_workspace`.

Attach your local standard input/output/error streams to devenv. Create the directory where your project will live.
```zsh
$ docker attach devenv
# Inside devenv, for example
➜ take my-app/
➜ git init # then hack away
```

After your are done with development, detach with `<ctrl+p>,<ctrl+q>`. `<ctrl+c>` will stop the container completely.
