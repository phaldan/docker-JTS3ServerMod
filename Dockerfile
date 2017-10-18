FROM openjdk:8-jre-alpine

MAINTAINER Philipp Daniels <philipp.daniels@gmail.com>

ARG JTS3_SERVER_MOD_VERSION=6.4.0
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="JTS3ServerMod" \
      org.label-schema.version="${JTS3_SERVER_MOD_VERSION}" \
      org.label-schema.description="JTS3ServerMod is a Teamspeak 3 server bot written in Java language" \
      org.label-schema.url="https://www.stefan1200.de/forum/index.php?topic=2.0" \
      org.label-schema.usage="https://www.stefan1200.de/documentation/jts3servermod/readme.html" \
      org.label-schema.vcs-url="https://github.com/phaldan/docker-JTS3ServerMod" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vendor="PhALDan"

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

