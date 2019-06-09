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

# Working with an existing docker-compose.yml
If you have an existing Docker project you can easily expose a subdirectory of your workspace so your application can consume it. Create a docker-compose.override.yml to expose the volume your app will consume.
```yml
version: "3.7"
services:
  devenv:
    volumes:
      - my-app:/home/dev/workspace/my-app
      - /Users/jmera/.ssh:/home/dev/.ssh
    working_dir: /home/dev/workspace/my-app

volumes:
  my-app:
```

In the host machine, make sure to restart devenv. Also make sure permissions are set correctly. Lastly clone your repo.
```zsh
$ docker-compose up -d
$ docker exec -u root devenv chown -R dev:dev /home/dev/workspace/my-app/
$ docker attach devenv
➜ git clone https://github.com/jmera/my-app.git # note change in working_dir
```

Update your application's docker-compose.yml or docker-compose.override.yml to consume that volume.
```yml
# ...
services:
  my-app:
    volumes:
      - devenv_my-app:/path/to/my-app
# ...
volumes:
  devenv_my-app: { external: true }
```

And remember to `docker-compose up` in that that project as well for changes to take effect

# X11 support
TODO
