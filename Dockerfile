# Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-labrackup> for details.

ARG FRX_DOCKER_FROM=debian:stable-slim
FROM ${FRX_DOCKER_FROM}

LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"

ENV MINECRAFT_BACKUP_FTP_HOST= \
    MINECRAFT_BACKUP_FTP_PASS= \
    MINECRAFT_BACKUP_FTP_PORT= \
    MINECRAFT_BACKUP_FTP_USER=

COPY ./build ./Dockerfile ./LICENSE ./README.md  /frx/

RUN /frx/build

EXPOSE 80

VOLUME [ "/labrackup" ]

CMD [ "/frx/start" ]