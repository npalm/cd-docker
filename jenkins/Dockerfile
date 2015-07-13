FROM jenkins
MAINTAINER Niek Palm "dev.npalm@gmail.com"

USER root

RUN apt-get update && apt-get install wget curl apt-transport-https -y \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
  && sh -c 'echo "deb https://get.docker.com/ubuntu docker main" > /etc/apt/sources.list.d/docker.list' \
  && apt-get update \
  && groupadd docker && gpasswd -a jenkins docker \
  && apt-get install lxc-docker -y \
  && sh -c 'echo "DOCKER_OPTS=\"-H tcp://dockerhost:2375\"" > /etc/default/docker' \
  && update-rc.d docker disable \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#ENV SSH_TMP_KEY_FILES /jenkins/.ssh
#RUN mkdir -p ${SSH_TMP_KEY_FILES}
#RUN chown -R jenkins ${SSH_TMP_KEY_FILES}

COPY jenkins-extend.sh /usr/local/bin/jenkins-extend.sh

USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
COPY run-containerized /usr/local/bin/run-containerized
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
#RUN ssh-keygen -t rsa -N "" -f ${SSH_TMP_KEY_FILES}/id_rsa

ENTRYPOINT ["/usr/local/bin/jenkins-extend.sh"]

