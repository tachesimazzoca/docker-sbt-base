FROM openjdk:8u181

ARG scalaVersion
ARG sbtVersion

WORKDIR /tmp
RUN curl -LO https://dl.bintray.com/sbt/debian/sbt-"${sbtVersion}".deb && \
  dpkg -i sbt-"${sbtVersion}".deb && \
  rm sbt-"${sbtVersion}".deb && \
  apt-get update && \
  apt-get install sbt

WORKDIR /tmp/sbt-base
RUN mkdir project && \
  echo "sbt.version=${sbtVersion}" > project/build.properties && \
  echo "scalaVersion := \"${scalaVersion}\"" > build.sbt && \
  sbt sbtVersion && \
  cd /tmp && \
  rm -rf sbt-base

WORKDIR /root
