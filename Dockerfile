FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get -yq install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
# add docker group to match host's gid
RUN groupadd -g 466 docker
RUN apt-get update && apt-get -yq install docker-ce docker-ce-cli containerd.io
RUN usermod -a -G docker jenkins

USER jenkins
# generate plugins.txt with
# curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
# RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
