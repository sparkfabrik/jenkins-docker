FROM jenkins:2.0
MAINTAINER alessio.piazza@sparkfabrik.com

USER root

RUN apt-get update && \
    apt-get install build-essential -y && \
    curl -sSL https://get.docker.com/ | sh && \ 
    curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jenkins
