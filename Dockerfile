FROM jenkinsci/jenkins:2.11
MAINTAINER alessio.piazza@sparkfabrik.com

USER root
ENV COMPOSE_VERSION 1.7.1
RUN apt-get update && \
    apt-get install build-essential -y && \
    curl -sSL https://get.docker.com/ | sh && \
    curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    usermod -aG docker jenkins && \
    chmod +x /usr/local/bin/docker-compose && \
    usermod -aG docker jenkins && \
    apt-get autoremove -y  && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 2.11 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo 2.11 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

# Copy default configurations.
COPY default/* /usr/share/jenkins/ref/

# Install plugins.
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

# Back to jenkins user.
USER jenkins
