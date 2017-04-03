FROM openjdk:8-jre-alpine

MAINTAINER Philipp Daniels <philipp.daniels@gmail.com>

ARG JTS3_SERVER_MOD_VERSION=6.4.0

WORKDIR /JTS3ServerMod

RUN echo "## Downloading ${JTS3_SERVER_MOD_VERSION} ##" && \
  apk add --no-cache unzip wget && \
  update-ca-certificates && \
  wget "https://www.stefan1200.de/downloads/JTS3ServerMod_${JTS3_SERVER_MOD_VERSION}.zip" -O archive.zip && \
  unzip archive.zip -d / && \
  apk del --purge --no-cache unzip wget && \
  rm -R archive.zip JTS3ServerMod-Windows* documents/ tools/

VOLUME /JTS3ServerMod/config /JTS3ServerMod/plugins /JTS3ServerMod/log

COPY docker-entrypoint.sh .
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["-mx30M"]

