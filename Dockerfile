# Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-labrackup> for details.

ARG FRX_DOCKER_FROM=debian:stable-slim
FROM ${FRX_DOCKER_FROM}

LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"

ENV LABRACKUP_CONF_FILE=/labrackup/backups.yml

COPY ./build ./Dockerfile ./LICENSE ./README.md  /frx/

RUN /frx/build

VOLUME [ "/labrackup" ]

ENTRYPOINT [ "/frx/start" ]

CMD [ "${LABRACKUP_CONF_FILE}" ]