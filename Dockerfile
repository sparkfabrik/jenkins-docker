FROM jenkinsci/jenkins:2.21
MAINTAINER alessio.piazza@sparkfabrik.com

USER root
ENV COMPOSE_VERSION 1.8.0
ENV DOCKER_ENGINE_VERSION 1.11.2-0
RUN apt-get update && \
    apt-get install build-essential -y && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    mkdir -p /etc/apt/sources.list.d && \
    echo deb http://apt.dockerproject.org/repo3 ubuntu-trusty main > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y -q docker-engine=${DOCKER_ENGINE_VERSION}~jessie && \
    curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    usermod -aG docker jenkins && \
    chmod +x /usr/local/bin/docker-compose && \
    usermod -aG docker jenkins && \
    apt-get autoremove -y  && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 2.15 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo 2.15 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

# Copy default configurations.
COPY default/* /usr/share/jenkins/ref/

# Install plugins.
RUN /usr/local/bin/install-plugins.sh \
  ansicolor \
  authentication-tokens \
  build-pipeline-plugin \
  conditional-buildstep \
  cloverphp \
  copy-data-to-workspace-plugin \
  credentials \
  docker-build-publish \
  docker-commons \
  envinject \
  git \
  git-client \
  gitlab-hook \
  gitlab-merge-request-jenkins \
  gitlab-plugin \
  icon-shim \
  javadoc \
  jquery \
  junit \
  mask-passwords \
  matrix-project \
  script-security \
  nested-view \
  pam-auth \
  parameterized-trigger \
  phing \
  php \
  plain-credentials \
  plot \
  postbuild-task \
  project-stats-plugin \
  run-condition \
  scm-api \
  sidebar-link \
  simple-theme-plugin \
  slack \
  ssh-credentials \
  ssh-slaves \
  structs \
  s3 \
  tmpcleaner \
  token-macro \
  view-job-filters \
  workflow-step-api \
  ws-cleanup \
  htmlpublisher \
  violations \
  xunit \
  workflow-scm-step


# Back to jenkins user.
USER jenkins
