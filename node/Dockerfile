FROM node:0.10
MAINTAINER Niek Palm "dev.npalm@gmail.com"

RUN  apt-get update && apt-get install wget curl apt-transport-https -y \
  && sh -c 'echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java.list' \
  && sh -c 'echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java.list' \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
  && apt-get update \
  && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
  && apt-get install -y --force-yes oracle-java8-installer  \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
  && sh -c 'echo "deb http://packages.linuxmint.com debian import" >> /etc/apt/sources.list.d/firefox.list' \
  && gpg --keyserver pgp.mit.edu --recv-keys 3EE67F3D0FF405B2 && gpg --export 3EE67F3D0FF405B2 > 3EE67F3D0FF405B2.gpg \
  && apt-key add ./3EE67F3D0FF405B2.gpg && rm ./3EE67F3D0FF405B2.gpg \
  && wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
  && apt-get update && apt-get remove iceweasel && apt-get -y install \
     build-essential \
     git-core \
     xvfb \
     google-chrome-stable \
     firefox \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -d /builder -u 1000 -m -s /bin/bash builder
 
ENV CONTAINER_INIT /usr/local/bin/init-container
RUN echo '#!/usr/bin/env bash' > $CONTAINER_INIT ; chmod +x $CONTAINER_INIT \
   && echo 'Xvfb :0 -ac -screen 0 1024x768x24 > /dev/null 2>&1 &' >> $CONTAINER_INIT

USER builder
