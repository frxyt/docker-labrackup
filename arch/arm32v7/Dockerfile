# Copyright (c) 2019 FEROX YT EIRL, www.ferox.yt <devops@ferox.yt>
# Copyright (c) 2019 Jérémy WALTHER <jeremy.walther@golflima.net>
# See <https://github.com/frxyt/docker-labrackup> for details.

FROM frxyt/qemu-user-static:latest AS qemu
FROM arm32v7/debian:stable-slim
COPY --from=qemu /usr/bin/qemu-arm-static /usr/bin

LABEL maintainer="Jérémy WALTHER <jeremy@ferox.yt>"
ENV LABRACKUP_CONF_FILE=/labrackup/backups.yml \
    TERM=xterm-256color

COPY ./build/build /frx/build
RUN /frx/build
COPY ./build/start ./Dockerfile ./LICENSE ./README.md /frx/

VOLUME [ "/labrackup" ]
WORKDIR /labrackup

ENTRYPOINT [ "/frx/start" ]