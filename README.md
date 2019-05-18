# Docker Image for Labrackup, by [FEROX](https://ferox.yt)

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/frxyt/labrackup.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/frxyt/labrackup.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/frxyt/labrackup.svg)
![GitHub issues](https://img.shields.io/github/issues/frxyt/docker-labrackup.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/frxyt/docker-labrackup.svg)

Labrackup helps you to retrieve backups of multiple servers / services and to perform a local backup rotation.

* Docker Hub: https://hub.docker.com/r/frxyt/labrackup
* GitHub: https://github.com/frxyt/docker-labrackup

## Docker Hub Image

**`frxyt/labrackup`**

* amd64: **`frxyt/labrackup:latest`**, **`frxyt/labrackup:amd64`**
* arm32v7: **`frxyt/labrackup:arm32v7`**
* arm64v8: **`frxyt/labrackup:arm64v8`**

## Usage

* `docker run -v $(pwd):/labrackup frxyt/labrackup:latest`
* `docker run -v $(pwd):/labrackup frxyt/labrackup:latest /labrackup/backups.yml`
* `docker run -v $(pwd):/labrackup -e LABRACKUP_CONF_FILE=/labrackup/backups.yml frxyt/labrackup:latest`
  * Sample content for `backups.yml`:

    ```yml
    .template:sample_host1: &template_sample_host1
      remote_host: server.example.com
      remote_port: 22
      remote_user: labrackup
      remote_keyfile: /labrackup/labrackup@server.example.com

    backups:

      gitlab:
        <<: *template_sample_host1
        remote_path: /data/gitlab/opt/backups
        local_path: /labrackup/backups/server.example.com/gitlab
        local_rotate:
          - -I '*_gitlab_backup.tar' -d 7 -w 4 -m 12
          - -I '*_gitlab_config.tar.gz' -d 7 -w 4 -m 12
    
      grafana:
        <<: *template_sample_host1
        remote_path: /data/grafana/backups
        local_path: /labrackup/backups/server.example.com/grafana
        local_rotate: -I '*_grafana-db.tar.gz' -d 7 -w 4 -m 12
    ```

  * Generate a key with: `ssh-keygen -b 4096 -f labrackup@server.example.com`

### Structure of `backups.yml`

```yml
backups: # base node

  gitlab: # Name of the first backup
    remote_host: server1.example.com # IP or Hostname of the server
    remote_port: 22 # SSH Port
    remote_user: user1 # SSH User
    remote_keyfile: /labrackup/user1@server1.example.com # SSH Private key to use
    remote_path: /data/gitlab/opt/backups # Remote path where backup are stored
    local_path: /labrackup/backups/server1.example.com/gitlab # Local path where backups need to be retrieved
    local_rotate: # rotate-backup options, see bellow, as an array if multiples rotates must be performed
      - -I '*_gitlab_backup.tar' -d 7 -w 4 -m 12
      - -I '*_gitlab_config.tar.gz' -d 7 -w 4 -m 12

  grafana: # Name of the second backup
    remote_host: server2.example.com
    remote_port: 22
    remote_user: user2
    remote_keyfile: /labrackup/user2@server2.example.com
    remote_path: /data/grafana/backups
    local_path: /labrackup/backups/server2.example.com/grafana
    local_rotate: -I '*_grafana-db.tar.gz' -d 7 -w 4 -m 12 # rotate-backup options,
    # or as a string if only one rotation must be performed
  
  # Add as many backup sections as needed
```

* For all `local_rotate` options, see: https://rotate-backups.readthedocs.io/en/latest/readme.html#command-line

## Install Labrackup on ARM Server / Raspberry Pi

1. `ssh user@server.ip`, then, `sudo -s`
1. `apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y`
1. `apt-get install -y --fix-missing --install-recommends apt-transport-https apt-utils curl nano`
1. `curl -sSL https://get.docker.com | sh`
1. `mkdir /labrackup && cd /labrackup`
1. Create a `backups.yml` describing the services to backup: `nano backups.yml`
1. Add your private key or generate it: `ssh-keygen -b 4096 -f backups.key`
1. `docker run -v $(pwd):/labrackup frxyt/labrackup:arm32v7` (if you have an ARMv8 CPU, you can use `arm64v8` instead)
1. Add an hourly cron with: `crontab -e`

   `0 * * * * /usr/bin/docker run -v /labrackup:/labrackup frxyt/labrackup:arm32v7 >> /labrackup/backups.log 2>&1`

## Build

```sh
docker run --rm --privileged multiarch/qemu-user-static:register --reset
docker build -f Dockerfile              -t frxyt/labrackup:latest  .
docker build -f arch/amd64/Dockerfile   -t frxyt/labrackup:amd64   .
docker build -f arch/arm32v7/Dockerfile -t frxyt/labrackup:arm32v7 .
docker build -f arch/arm64v8/Dockerfile -t frxyt/labrackup:arm64v8 .
```

## License

This project and images are published under the [MIT License](LICENSE).

```
MIT License

Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```