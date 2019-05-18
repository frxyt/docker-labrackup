# Docker Image for Labrackup, by [FEROX](https://ferox.yt)

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/frxyt/labrackup.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/frxyt/labrackup.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/frxyt/labrackup.svg)
![GitHub issues](https://img.shields.io/github/issues/frxyt/docker-labrackup.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/frxyt/docker-labrackup.svg)

* Docker Hub: https://hub.docker.com/r/frxyt/labrackup
* GitHub: https://github.com/frxyt/docker-labrackup

## Docker Hub Image

**`frxyt/labrackup`**

## Usage

* `docker run -v $(pwd):/labrackup frxyt/labrackup:latest /labrackup/backups.yml`
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

## Build

```sh
docker run --rm --privileged multiarch/qemu-user-static:register --reset
docker build -f Dockerfile              -t frxyt/labrackup:latest .
docker build -f arch/amd64/Dockerfile   -t frxyt/labrackup:latest .
docker build -f arch/arm32v7/Dockerfile -t frxyt/labrackup:latest .
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