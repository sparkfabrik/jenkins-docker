FROM jenkinsci/jenkins:2.11
MAINTAINER alessio.piazza@sparkfabrik.com

# Jenkins is using jenkins user, we need root to install things.
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

USER root
ENV COMPOSE_VERSION 1.7.1
RUN apt-get update && \
    apt-get install build-essential -y && \
    curl -sSL https://get.docker.com/ | sh && \
    curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    apt-get autoremove -y  && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 2.11 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.11 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
COPY config.xml /usr/share/jenkins/ref/

USER jenkins
