FROM jenkins:2.19.3
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
  backup \
  ansicolor \
  authentication-tokens \
  build-pipeline-plugin \
  build-monitor \
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
  ws-cleanup \
  htmlpublisher \
  violations \
  xunit \
  ace-editor \
  ant \
  antisamy-markup-formatter \
  branch-api \
  cloudbees-folder \
  cvs \
  docker-build-step \
  docker-plugin \
  docker-workflow \
  durable-task \
  external-monitor-job \
  git-server \
  github \
  github-api \
  github-branch-source \
  github-organization-folder \
  google-metadata-plugin \
  google-oauth-plugin \
  google-source-plugin \
  handlebars \
  jquery-detached \
  kubernetes \
  ldap \
  mailer \
  mapdb-api \
  matrix-auth \
  maven-plugin \
  momentjs \
  oauth-credentials \
  pipeline-build-step \
  pipeline-input-step \
  pipeline-rest-api \
  pipeline-stage-step \
  pipeline-stage-view \
  subversion \
  translation \
  windows-slaves \
  workflow-aggregator \
  workflow-api \
  workflow-basic-steps \
  workflow-cps \
  workflow-cps-global-lib \
  workflow-durable-task-step \
  workflow-job \
  workflow-multibranch \
  workflow-support \
  workflow-step-api \
  workflow-scm-step

# Back to jenkins user.
USER jenkins
