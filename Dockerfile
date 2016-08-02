FROM jenkinsci/jenkins:2.15
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
