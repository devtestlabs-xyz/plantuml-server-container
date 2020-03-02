#############################################
# Builder image
#############################################
# Maven builder image
FROM maven:3.6-jdk-8-alpine AS builder

RUN apk update && apk upgrade && \
    apk add --no-cache git openssh

# Clone PlantUML repo
RUN for i in {1..5}; do git clone https://github.com/plantuml/plantuml-server.git; done && \
  cd plantuml-server && \
  git checkout v1.2020.1 && \
  mkdir /app && \
  cp pom.xml /app && \
  cp -R src /app/src

WORKDIR /app
RUN mvn --batch-mode --define java.net.useSystemProxies=true package

#############################################
# Runtime image
#############################################
# PlantUML Jetty server runtime image
FROM jetty:9.4-jre8-alpine
LABEL maintainer Ryan Craig <rcraig@melaleuca.com>

# Arguments to pass in at image build-time
ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

USER root


RUN apk update && \
#    apk add --no-cache graphviz font-noto msttcorefonts-installer fontconfig
    apk add --no-cache graphviz font-noto fontconfig

COPY fonts/*.ttf /usr/share/fonts/

#RUN update-ms-fonts && \
RUN fc-cache -f && \
    fc-list

USER jetty

ENV GRAPHVIZ_DOT=/usr/bin/dot

ARG BASE_URL=ROOT
COPY --from=builder /app/target/plantuml.war /var/lib/jetty/webapps/$BASE_URL.war

# http://label-schema.org/rc1/ namespace labels
LABEL org.label-schema.schema-version="1.0"
#LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="plantuml/plantuml-server"
LABEL org.label-schema.description="PlantUML Server runtime"
LABEL org.label-schema.url="http://plantuml.com/"
LABEL org.label-schema.vcs-url="https://github.com/plantuml/plantuml-server"
#LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="PlantUML"
#LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run -d -p 8080:8080 devops/plantuml-server:jetty-alpine"
