FROM openjdk:8u171-jre-alpine3.8@sha256:e3168174d367db9928bb70e33b4750457092e61815d577e368f53efb29fea48b

MAINTAINER Philipp Daniels <philipp.daniels@gmail.com>

ARG JTS3_SERVER_MOD_VERSION=6.5.0
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
  apk add --no-cache libarchive-tools wget && \
  update-ca-certificates && \
  wget -qO- "https://www.stefan1200.de/downloads/JTS3ServerMod_${JTS3_SERVER_MOD_VERSION}.zip" | bsdtar -xf- --strip 1 && \
  apk del --purge --no-cache libarchive-tools wget && \
  rm -R JTS3ServerMod-Windows* documents/ tools/

VOLUME /JTS3ServerMod/config /JTS3ServerMod/plugins /JTS3ServerMod/log

COPY docker-entrypoint.sh .
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["-mx30M"]

