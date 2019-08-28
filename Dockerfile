FROM alpine:3.10.1@sha256:6a92cd1fcdc8d8cdec60f33dda4db2cb1fcdcacf3410a8e05b3741f44a9b5998

ENV JTS3_SERVER_MOD_VERSION=6.5.5
RUN echo "## Downloading ${JTS3_SERVER_MOD_VERSION} ##" && \
  apk add --no-cache libarchive-tools && \
  wget -qO- "https://www.stefan1200.de/downloads/JTS3ServerMod_${JTS3_SERVER_MOD_VERSION}.zip" | bsdtar -xf- && \
  rm -R /JTS3ServerMod/JTS3ServerMod-Windows* /JTS3ServerMod/documents/ /JTS3ServerMod/tools/


FROM openjdk:8u171-jre-alpine3.8@sha256:8fce9c197de91e925595a74e159b82b589f70baf2e086f6e63a8b8c8e193a8ca
MAINTAINER Philipp Daniels <philipp.daniels@gmail.com>
ENV JTS3_SERVER_MOD_VERSION=6.5.5

WORKDIR /JTS3ServerMod
COPY --from=0 /JTS3ServerMod .
VOLUME /JTS3ServerMod/config /JTS3ServerMod/plugins /JTS3ServerMod/log

COPY docker-entrypoint.sh .
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["-mx30M"]

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
