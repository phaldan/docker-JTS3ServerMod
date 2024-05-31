ARG VERSION="6.5.7_3"

FROM alpine
ARG VERSION
ENV JTS3_SERVER_MOD_VERSION=$VERSION
WORKDIR /tmp/dl
RUN echo "## Downloading ${JTS3_SERVER_MOD_VERSION} ##" && \
  apk add --no-cache libarchive-tools && \
  wget -q "https://www.stefan1200.de/downloads/JTS3ServerMod_${JTS3_SERVER_MOD_VERSION}.zip" -O JTS3.zip && \
  unzip -q JTS3.zip

WORKDIR /JTS3ServerMod
RUN cp -R /tmp/dl/JTS3ServerMod/* . && \
  rm -R /JTS3ServerMod/JTS3ServerMod-Windows* /JTS3ServerMod/documents/ /JTS3ServerMod/tools/


FROM eclipse-temurin:21-jre-alpine
MAINTAINER Fabian Wünderich <fabian@wuenderich.de>
ARG VERSION
ENV JTS3_SERVER_MOD_VERSION=$VERSION

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
      org.label-schema.vcs-url="https://github.com/fanonwue/docker-JTS3ServerMod" \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.vendor="fanonwue"
