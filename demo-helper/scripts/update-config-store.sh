#!/bin/bash

DEMOBOT_REMOTE=demo-bot
SCTRICTMODE=0
ROOT_REPO_NAME="demo-school"
shopt -s expand_aliases

connectRetryCount=0
while [ ! "running" == $(docker inspect ${GITEA_HOST} | jq -r '.[0].State.Status') ]
do
  connectRetryCount=$(( $connectRetryCount + 1 ))
  echo "waiting for gitea server to start... $connectRetryCount"
  sleep 1
done

GITEA_PORT=$(nmap ${GITEA_HOST} | grep ppp | grep -oE '^[0-9]+')
GITEA_URL="http://${GITEA_HOST}:${GITEA_PORT}"
while [[ -z $(curl -s ${GITEA_URL} | grep '<title> Gitea: Git with a cup of tea</title>') ]]
do
  GITEA_PORT=$(nmap ${GITEA_HOST} | grep ppp | grep -oE '^[0-9]+')
  GITEA_URL="http://${GITEA_HOST}:${GITEA_PORT}"
  connectRetryCount=$(( $connectRetryCount + 1 ))
  echo "waiting for gitea server to start serving... $connectRetryCount"
  sleep 1
done

pushd . > /dev/null
cd /root/config-store

export GIT_REPOSITORY_USERNAME=${GITEA_ADMIN_USERNAME}
export GIT_REPOSITORY_TOKEN=${GITEA_ADMIN_PASSWORD}

/scripts/auto-git.sh push --force "${DEMOBOT_REMOTE}" main


popd > /dev/null
