# Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-labrackup> for details.

ARG FRX_DOCKER_FROM=debian:stable-slim
FROM ${FRX_DOCKER_FROM}

LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"
ENV LABRACKUP_CONF_FILE=/labrackup/backups.yml \
    LABRACKUP_DEBUG=0 \
    TERM=xterm-256color

COPY ./build/build /frx/build
RUN /frx/build
COPY ./build/start ./Dockerfile ./LICENSE ./README.md /frx/

VOLUME [ "/labrackup" ]
WORKDIR /labrackup

ENTRYPOINT [ "/frx/start" ]