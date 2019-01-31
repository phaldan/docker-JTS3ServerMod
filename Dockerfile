FROM alpine:3.9@sha256:b3dbf31b77fd99d9c08f780ce6f5282aba076d70a513a8be859d8d3a4d0c92b8

ENV JTS3_SERVER_MOD_VERSION=6.5.5
RUN echo "## Downloading ${JTS3_SERVER_MOD_VERSION} ##" && \
  apk add --no-cache libarchive-tools && \
  wget -qO- "https://www.stefan1200.de/downloads/JTS3ServerMod_${JTS3_SERVER_MOD_VERSION}.zip" | bsdtar -xf- && \
  rm -R /JTS3ServerMod/JTS3ServerMod-Windows* /JTS3ServerMod/documents/ /JTS3ServerMod/tools/


FROM openjdk:8u171-jre-alpine3.8@sha256:e3168174d367db9928bb70e33b4750457092e61815d577e368f53efb29fea48b
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
