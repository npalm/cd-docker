#! /bin/bash

set -e

if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating keyfiles"
  ssh-keygen -t rsa -C "jenkins@devoxx" -N "" -f ~/.ssh/id_rsa
fi

exec /usr/local/bin/jenkins.sh $@
